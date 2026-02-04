import 'package:flutter/material.dart';
import '/auth/widget/admin_navbarr.dart';

class PeminjamanPage extends StatefulWidget {
  const PeminjamanPage({super.key});

  @override
  State<PeminjamanPage> createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  final Color primary = const Color(0xFF6B3E1E);
  final Color bg = const Color(0xFFEAD7C3);

  List<Map<String, String>> peminjamanList = [
    {
      'kode': 'PMJ-001',
      'nama': 'Muhammad Raju',
      'jabatan': 'Siswa',
      'tglPinjam': '01/01/2024',
      'tglKembali': '03/01/2024',
      'status': 'Dipinjam',
    },
    {
      'kode': 'PMJ-002',
      'nama': 'Catrika Cantika',
      'jabatan': 'Guru',
      'tglPinjam': '02/01/2024',
      'tglKembali': '04/01/2024',
      'status': 'Selesai',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      // ===== NAVBAR ADMIN =====
      bottomNavigationBar: const AdminNavbar(currentIndex: 2),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== HEADER =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primary,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: const Text(
                "Management\nPeminjaman",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Daftar Peminjaman",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            // ===== LIST =====
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: peminjamanList.length,
                itemBuilder: (context, index) {
                  final data = peminjamanList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['kode']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data['nama']!,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Tanggal Pinjam : ${data['tglPinjam']}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Tanggal Kembali : ${data['tglKembali']}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Chip(
                              label: Text(
                                data['status']!,
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                  onPressed: () =>
                                      _openEdit(context, index),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () =>
                                      _confirmDelete(context, index),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // ================= EDIT =================
  void _openEdit(BuildContext context, int index) {
    final namaController =
        TextEditingController(text: peminjamanList[index]['nama']);
    String status = peminjamanList[index]['status']!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Edit Peminjaman",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: namaController,
                decoration: _input("Nama Peminjam"),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: status,
                items: ['Dipinjam', 'Selesai', 'Dibatalkan']
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => status = v!,
                decoration: _input("Status"),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary),
                      onPressed: () {
                        setState(() {
                          peminjamanList[index]['nama'] =
                              namaController.text;
                          peminjamanList[index]['status'] = status;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Simpan"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // ================= DELETE =================
  void _confirmDelete(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Yakin ingin menghapus data ini?"),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red),
                      onPressed: () {
                        setState(() {
                          peminjamanList.removeAt(index);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Hapus"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  InputDecoration _input(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
