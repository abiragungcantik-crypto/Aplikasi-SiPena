import 'package:flutter/material.dart';
import 'package:sipena/admin/widget/admin_navbarr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class KategoriPage extends StatefulWidget {
  const KategoriPage({super.key});

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  // Controller untuk input dialog
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  static const Color espresso = Color(0xFF5D3216);
  static const Color background = Color(0xFFC9B097);
  static const Color vanilla = Color(0xFFD9C5B2);

  // Stream data real-time dari tabel 'kategori'
  final Stream<List<Map<String, dynamic>>> _kategoriStream =
      Supabase.instance.client.from('kategori').stream(primaryKey: ['id']).order('nama_kategori');

  // --- FUNGSI CRUD ---

  // Simpan Kategori Baru
  // Simpan Kategori Baru dengan loading indicator sederhana
  Future<void> _simpanKategori() async {
    if (_kategoriController.text.isEmpty) return;
    
    // Tampilkan loading snackbar atau dialog jika perlu
    try {
      await supabase.from('kategori').insert({
        'nama_kategori': _kategoriController.text,
        'deskripsi': _deskripsiController.text,
      });
      
      if (mounted) {
        _clearForm();
        Navigator.pop(context);
        _showSnackBar("Kategori berhasil ditambahkan!");
      }
    } catch (e) {
      // Jika masih error permission, pesan ini akan membantu diagnosa
      debugPrint("Full Error: $e"); 
      _showSnackBar("Gagal Simpan: Pastikan izin Database sudah di-GRANT");
    }
  }

  // Update Kategori
  Future<void> _updateKategori(int id) async {
    try {
      await supabase.from('kategori').update({
        'nama_kategori': _kategoriController.text,
        'deskripsi': _deskripsiController.text,
      }).eq('id', id);
      _clearForm();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      _showSnackBar("Error Update: $e");
    }
  }

  // Hapus Kategori
  Future<void> _hapusKategori(int id) async {
    try {
      await supabase.from('kategori').delete().eq('id', id);
      _showSnackBar("Kategori berhasil dihapus");
    } catch (e) {
      _showSnackBar("Gagal menghapus: Kategori mungkin masih digunakan oleh data alat.");
    }
  }

  void _clearForm() {
    _kategoriController.clear();
    _deskripsiController.clear();
  }

  void _showSnackBar(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  // --- UI COMPONENTS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: const AdminNavbar(currentIndex: 3),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 25, left: 20),
            color: espresso,
            child: const Text(
              'Kelola Kategori',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),

          // Tombol Tambah
          Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                _clearForm();
                _showFormDialog(context, null);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: espresso, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: espresso),
                    SizedBox(width: 8),
                    Text("Tambah Kategori baru",
                        style: TextStyle(color: espresso, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),

          // List Kategori (Real-time)
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _kategoriStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: espresso));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada kategori"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return _buildKategoriCard(item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: espresso, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        title: Text(
          item['nama_kategori'] ?? 'Tanpa Nama',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            item['deskripsi'] ?? '-',
            style: const TextStyle(color: vanilla, fontSize: 12),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit Button
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.amber),
              onPressed: () {
                _kategoriController.text = item['nama_kategori'];
                _deskripsiController.text = item['deskripsi'] ?? '';
                _showFormDialog(context, item['id']);
              },
            ),
            // Delete Button
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () => _confirmDelete(item['id'], item['nama_kategori']),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog Form (Untuk Tambah & Edit)
  void _showFormDialog(BuildContext context, int? id) {
    bool isEdit = id != null;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: vanilla,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEdit ? "Edit Kategori" : "Tambah Kategori",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: espresso),
              ),
              const SizedBox(height: 20),
              _buildDialogField("Nama Kategori", _kategoriController),
              _buildDialogField("Deskripsi", _deskripsiController, maxLines: 3),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal", style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: espresso),
                      onPressed: () => isEdit ? _updateKategori(id) : _simpanKategori(),
                      child: const Text("Simpan", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialogField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: espresso, fontSize: 13)),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  // Dialog Konfirmasi Hapus
  void _confirmDelete(int id, String nama) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Kategori?"),
        content: Text("Apakah Anda yakin ingin menghapus kategori '$nama'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _hapusKategori(id);
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}