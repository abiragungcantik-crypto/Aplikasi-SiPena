import 'package:flutter/material.dart';

// Gunakan konstanta yang sama agar konsisten di seluruh aplikasi
const Color primaryBrown = Color(0xFF6D3C18);
const Color bgBrown = Color(0xFFD9C0A7);
const Color secondaryBrown = Color(0xFFE2D1C1);

class KembaliPage extends StatelessWidget {
  const KembaliPage({super.key});

  @override
  Widget build(BuildContext context) {
    // HAPUS Scaffold & AppBar karena sudah dikelola MainPetugasScreen
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'RIWAYAT PENGEMBALIAN',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryBrown,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondaryBrown.withOpacity(0.4), // Menggunakan warna yang sama dengan ApprovalCard
        border: Border.all(color: primaryBrown.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryBrown, 
                  borderRadius: BorderRadius.circular(12)
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 25),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name, 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primaryBrown)
                  ),
                  Text(
                    item, 
                    style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500)
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          // Info Tanggal
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _rowTanggal('Tgl Pinjam', tglPinjam),
                const Divider(height: 10, color: Colors.black12),
                _rowTanggal('Tgl Kembali', tglKembali),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // Tombol Konfirmasi
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Logika Update Database
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBrown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
              ),
              child: const Text(
                'Konfirmasi Pengembalian', 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowTanggal(String label, String tgl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        Text(tgl, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }
}