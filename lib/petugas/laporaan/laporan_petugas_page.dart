import 'package:flutter/material.dart';

import '../Pengembalian/penngembalian_page.dart';

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              color: Color(0xFF5D3011),
            ),
          ),
        ),
        const SizedBox(height: 25),

        // Ringkasan Bar Statistik
        _buildStatProgress("Peminjaman Berhasil", 0.8, Colors.green),
        _buildStatProgress("Peminjaman Ditolak", 0.2, Colors.red),
        _buildStatProgress("Alat Sedang Dipinjam", 0.5, Colors.blue),
        
        const SizedBox(height: 30),
        const Text(
          "Aktivitas Terkini",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text("${(value * 100).toInt()}%"),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white,
            color: color,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildReportTile(String title, String date, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryBrown.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryBrown,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text(date, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: primaryBrown),
        onTap: () {},
      ),
    );
  }
}