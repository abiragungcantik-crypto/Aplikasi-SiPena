import 'package:flutter/material.dart';

// Gunakan konstanta yang sama agar konsisten di seluruh aplikasi
const Color primaryBrown = Color(0xFF6D3C18);
const Color bgBrown = Color(0xFFD9C0A7);
const Color secondaryBrown = Color(0xFFE2D1C1);

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Tetap tanpa Scaffold agar tidak double header
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 10),
        const Center(
          child: Text(
            'LAPORAN STATISTIK',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryBrown, // Konsisten dengan warna tema
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 25),

        // Ringkasan Bar Statistik (Warna disesuaikan agar tetap elegan)
        _buildStatProgress("Peminjaman Berhasil", 0.8, const Color(0xFF4CAF50)),
        _buildStatProgress("Peminjaman Ditolak", 0.2, const Color(0xFFE57373)),
        _buildStatProgress("Alat Sedang Dipinjam", 0.5, const Color(0xFF64B5F6)),
        
        const SizedBox(height: 30),
        const Text(
          "Aktivitas Terkini",
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 16, 
            color: primaryBrown
          ),
        ),
        const SizedBox(height: 15),

        // Daftar Laporan Ringkas
        _buildReportTile("Laporan Bulanan Januari", "28 Jan 2026", Icons.picture_as_pdf),
        _buildReportTile("Daftar Inventaris Alat", "15 Jan 2026", Icons.description),
        _buildReportTile("Log Aktivitas Petugas", "01 Jan 2026", Icons.history),
      ],
    );
  }

  Widget _buildStatProgress(String label, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label, 
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)
              ),
              Text(
                "${(value * 100).toInt()}%", 
                style: const TextStyle(fontWeight: FontWeight.bold, color: primaryBrown)
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Progress bar yang lebih lembut
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: secondaryBrown.withOpacity(0.5),
              color: color,
              minHeight: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportTile(String title, String date, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: secondaryBrown.withOpacity(0.4), // Senada dengan card di page lain
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryBrown.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryBrown,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        title: Text(
          title, 
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryBrown)
        ),
        subtitle: Text(
          date, 
          style: const TextStyle(fontSize: 12, color: Colors.black54)
        ),
        trailing: const Icon(Icons.chevron_right, color: primaryBrown),
        onTap: () {
          // Aksi buka detail laporan
        },
      ),
    );
  }
}