import 'package:flutter/material.dart';
import 'package:sipena/admin/widget/admin_navbarr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AlatPage extends StatefulWidget {
  const AlatPage({super.key});

  @override
  State<AlatPage> createState() => _AlatPageState();
}

class _AlatPageState extends State<AlatPage> {
  static const Color bgColor = Color(0xFFC9B097);
  static const Color primary = Color(0xFF5D3216);
  static const Color vanilla = Color(0xFFD9C5B2);

  final SupabaseClient supabase = Supabase.instance.client;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();

  // Memperbaiki deklarasi Stream untuk sinkronisasi yang lebih stabil
  late final Stream<List<Map<String, dynamic>>> _alatStream;

  @override
  void initState() {
    super.initState();
    // Inisialisasi stream di initState
    _alatStream = supabase
        .from('alat')
        .stream(primaryKey: ['id'])
        .order('id', ascending: false);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _stokController.dispose();
    _hargaController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  Future<void> _simpanAlat() async {
    if (_namaController.text.isEmpty || 
        _stokController.text.isEmpty || 
        _hargaController.text.isEmpty) {
      _showSnackBar("Semua kolom wajib diisi!");
      return;
    }

    try {
      await supabase.from('alat').insert({
        'nama_alat': _namaController.text.trim(),
        'stok': int.parse(_stokController.text.trim()),
        'harga_sewa': int.parse(_hargaController.text.trim()),
        'kategori_id': int.tryParse(_kategoriController.text.trim()) ?? 1,
      });

      if (mounted) {
        _clearForm();
        Navigator.pop(context);
        _showSnackBar("Data berhasil disimpan!");
      }
    } catch (e) {
      _showSnackBar("Gagal simpan: $e");
    }
  }

  Future<void> _hapusAlat(int id) async {
    try {
      // Langsung hapus, StreamBuilder akan mendeteksi perubahan jika Replication ON
      await supabase.from('alat').delete().eq('id', id);
      _showSnackBar("Data berhasil dihapus");
    } catch (e) {
      _showSnackBar("Gagal menghapus: $e");
    }
  }

  void _confirmHapus(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Alat"),
        content: const Text("Apakah Anda yakin ingin menghapus data ini?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _hapusAlat(id);
            }, 
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    _namaController.clear();
    _stokController.clear();
    _hargaController.clear();
    _kategoriController.clear();
  }

  void _showSnackBar(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 2)));
  }

  // --- UI WIDGETS ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: const AdminNavbar(currentIndex: 1),
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 15),
          _buildAddButton(),
          const SizedBox(height: 15),
          Expanded(child: _buildListStream()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 25, left: 20),
      decoration: const BoxDecoration(
        color: primary, 
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
      width: double.infinity,
      child: const Text("Manajemen\nAlat Pinjaman", 
        style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.1)),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: _openFormTambah,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary, 
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
        ),
        icon: const Icon(Icons.add_box, color: Colors.white),
        label: const Text("TAMBAH DATA ALAT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildListStream() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _alatStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: primary));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Data alat kosong", style: TextStyle(color: primary, fontWeight: FontWeight.bold)));
        }

        final listAlat = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: listAlat.length,
          itemBuilder: (context, index) {
            final item = listAlat[index];
            return Card(
              color: primary,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text(item['nama_alat'] ?? '-', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text("Stok: ${item['stok']} | Harga: Rp ${item['harga_sewa']}", style: const TextStyle(color: vanilla)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_forever, color: Colors.redAccent, size: 28),
                  onPressed: () => _confirmHapus(item['id']),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _openFormTambah() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: bgColor, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tambah Alat Baru", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primary)),
              const SizedBox(height: 15),
              _buildInput(_namaController, "Nama Alat"),
              const SizedBox(height: 10),
              _buildInput(_stokController, "Jumlah Stok", isNumber: true),
              const SizedBox(height: 10),
              _buildInput(_hargaController, "Harga Sewa", isNumber: true),
              const SizedBox(height: 10),
              _buildInput(_kategoriController, "ID Kategori", isNumber: true),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primary, minimumSize: const Size(double.infinity, 50)),
                onPressed: _simpanAlat,
                child: const Text("SIMPAN DATA", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }
}