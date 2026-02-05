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
  final TextEditingController _stokController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  static const Color espresso = Color(0xFF5D3216);
  static const Color background = Color(0xFFC9B097);
  static const Color vanilla = Color(0xFFD9C5B2);

  // Stream data real-time dari tabel 'kategori'
  final Stream<List<Map<String, dynamic>>> _kategoriStream =
      Supabase.instance.client.from('kategori').stream(primaryKey: ['id']);

  // Fungsi Simpan ke Supabase
  Future<void> _simpanKategori() async {
    if (_kategoriController.text.isEmpty) return;
    try {
      await supabase.from('kategori').insert({
        'nama_kategori': _kategoriController.text,
        'stok_alat': _stokController.text,
        'deskripsi': _deskripsiController.text,
      });
      if (mounted) {
        _kategoriController.clear();
        _stokController.clear();
        _deskripsiController.clear();
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

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
            child: const Text('Kategori',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          
          // Tombol Tambah
          Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () => _showAddDialog(context),
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
                    Text("Tambah Kategori baru", style: TextStyle(color: espresso, fontWeight: FontWeight.bold)),
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
                    return _buildKategoriCard(
                      item['nama_kategori'] ?? 'Tanpa Nama',
                      item['stok_alat']?.toString() ?? '0',
                      item['deskripsi'] ?? '-',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriCard(String title, String stok, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: espresso, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          Text("Stok Alat : $stok Tersedia", style: const TextStyle(color: vanilla, fontSize: 12)),
          const SizedBox(height: 5),
          Text(detail, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: vanilla,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tambah Kategori", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: espresso)),
              const SizedBox(height: 20),
              _buildDialogField("Nama Kategori", _kategoriController),
              _buildDialogField("Stok Awal", _stokController),
              _buildDialogField("Deskripsi", _deskripsiController),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal"))),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: espresso),
                      onPressed: _simpanKategori,
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

  Widget _buildDialogField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: espresso)),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true, fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}