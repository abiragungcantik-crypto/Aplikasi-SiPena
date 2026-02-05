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

  final _namaController = TextEditingController();
  final _stokController = TextEditingController();
  final _hargaController = TextEditingController();
  
  int? _selectedKategoriId;
  List<Map<String, dynamic>> _categories = [];
  
  // Perubahan 1: Stream tidak lagi menggunakan 'late final' agar inisialisasi lebih fleksibel
  Stream<List<Map<String, dynamic>>>? _alatStream;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _initStream();
  }

  // Perubahan 2: Fungsi inisialisasi stream dipisah untuk memastikan sinkronisasi ke tabel 'alat'
  void _initStream() {
    _alatStream = supabase
        .from('alat')
        .stream(primaryKey: ['id'])
        .order('id', ascending: false);
  }

  Future<void> _fetchCategories() async {
    try {
      final data = await supabase.from('kategori').select('id, nama_kategori');
      if (mounted) {
        setState(() {
          _categories = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _stokController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  Future<void> _upsertAlat({int? id}) async {
    if (_namaController.text.isEmpty || 
        _stokController.text.isEmpty || 
        _hargaController.text.isEmpty || 
        _selectedKategoriId == null) {
      _showSnackBar("Semua kolom wajib diisi!");
      return;
    }

    try {
      final payload = {
        'nama_alat': _namaController.text.trim(),
        'stok': int.parse(_stokController.text.trim()),
        'harga_sewa': int.parse(_hargaController.text.trim()),
        'kategori_id': _selectedKategoriId,
      };

      if (id == null) {
        await supabase.from('alat').insert(payload);
      } else {
        await supabase.from('alat').update(payload).eq('id', id);
      }

      if (mounted) {
        Navigator.pop(context);
        _clearForm();
        _showSnackBar(id == null ? "Data berhasil ditambah!" : "Data berhasil diperbarui!");
      }
    } catch (e) {
      _showSnackBar("Gagal menyimpan data: $e");
    }
  }

  Future<void> _hapusAlat(int id) async {
    try {
      await supabase.from('alat').delete().eq('id', id);
      _showSnackBar("Data berhasil dihapus");
    } catch (e) {
      _showSnackBar("Gagal menghapus: $e");
    }
  }

  void _clearForm() {
    _namaController.clear();
    _stokController.clear();
    _hargaController.clear();
    setState(() => _selectedKategoriId = null);
  }

  void _showSnackBar(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2))
    );
  }

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
        onPressed: () => _openFormAlat(),
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: primary));
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.red)));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Data alat kosong", style: TextStyle(color: primary)));
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
                title: Text(item['nama_alat'] ?? '-', 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text("Stok: ${item['stok']} | Harga: Rp ${item['harga_sewa']}", 
                    style: const TextStyle(color: vanilla)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () => _openFormAlat(item: item),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                      onPressed: () => _confirmHapus(item['id']),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _openFormAlat({Map<String, dynamic>? item}) {
    if (item != null) {
      _namaController.text = item['nama_alat'].toString();
      _stokController.text = item['stok'].toString();
      _hargaController.text = item['harga_sewa'].toString();
      _selectedKategoriId = item['kategori_id'];
    } else {
      _clearForm();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: bgColor, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item == null ? "Tambah Alat Baru" : "Edit Alat", 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primary)),
                const SizedBox(height: 15),
                _buildInput(_namaController, "Nama Alat"),
                const SizedBox(height: 10),
                _buildInput(_stokController, "Jumlah Stok", isNumber: true),
                const SizedBox(height: 10),
                _buildInput(_hargaController, "Harga Sewa", isNumber: true),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  value: _selectedKategoriId,
                  dropdownColor: vanilla,
                  decoration: InputDecoration(
                    hintText: "Pilih Kategori",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                  items: _categories.map((cat) {
                    return DropdownMenuItem<int>(
                      value: cat['id'],
                      child: Text(cat['nama_kategori'].toString()),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setModalState(() => _selectedKategoriId = val);
                    setState(() => _selectedKategoriId = val);
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary, minimumSize: const Size(double.infinity, 50)),
                  onPressed: () => _upsertAlat(id: item?['id']),
                  child: Text(item == null ? "SIMPAN DATA" : "UPDATE DATA", 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmHapus(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Alat"),
        content: const Text("Data ini akan dihapus permanen. Lanjutkan?"),
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