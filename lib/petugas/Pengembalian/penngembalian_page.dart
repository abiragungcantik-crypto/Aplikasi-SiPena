import 'package:flutter/material.dart';

// Pastikan primaryBrown didefinisikan atau diimport jika beda file
const Color primaryBrown = Color(0xFF4E342E); 
const Color backgroundBrown = Color(0xFFC5A381);

class KembaliPage extends StatelessWidget {
  const KembaliPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBrown, // Tambahkan ini agar warna seragam
      appBar: AppBar(
        backgroundColor: primaryBrown,
        title: const Text("Dashboard Petugas", style: TextStyle(fontSize: 14, color: Colors.white)),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'RIWAYAT PENGEMBALIAN',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryBrown,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                _buildKembaliCard(
                  name: 'Cantika Cantiku',
                  item: 'Layar Proyektor',
                  tglPinjam: '26 Januari 2026',
                  tglKembali: '26 Januari 2026',
                ),
                _buildKembaliCard(
                  name: 'Muhammad Raju',
                  item: 'Scanner',
                  tglPinjam: '01 Januari 2026',
                  tglKembali: '02 Januari 2026',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKembaliCard({
    required String name,
    required String item,
    required String tglPinjam,
    required String tglKembali,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD9B99B), // Sesuaikan dengan warna card sebelumnya
        border: Border.all(color: primaryBrown.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: primaryBrown, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(item, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('tgl pinjam : $tglPinjam', style: const TextStyle(fontSize: 11, color: Colors.black54)),
          Text('tgl kembali : $tglKembali', style: const TextStyle(fontSize: 11, color: Colors.black54)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Logika Konfirmasi (Database Update) bisa di sini
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBrown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Konfirmasi Pengembalian', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}