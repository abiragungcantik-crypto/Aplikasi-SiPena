import 'package:flutter/material.dart';
import 'package:sipena/log out/log out.dart';// Import Service Logout
import 'package:sipena/auth/widget/admin_navbarr.dart'; // Sesuaikan path navbar kamu

class LogAktivitasPage extends StatelessWidget {
  const LogAktivitasPage({super.key});

  // Variabel Warna Tema
  final Color espresso = const Color(0xFF5D3216);
  final Color vanilla = const Color(0xFFD9C5B2);
  final Color background = const Color(0xFFC9B097);
  final Color accentGreen = const Color(0xFF99B898); 
  final Color accentOrange = const Color(0xFFE5B181); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      // Navbar tetap di index 4 (atau sesuaikan dengan urutan menu kamu)
      bottomNavigationBar: const AdminNavbar(currentIndex: 4), 

      body: Column(
        children: [
          // --- HEADER CUSTOM DENGAN TOMBOL LOGOUT ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 25, left: 20, right: 15),
            decoration: BoxDecoration(
              color: espresso,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Log\nAktivitas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                // Tombol Logout di Pojok Kanan Atas Header
                IconButton(
                  onPressed: () => AuthService.logout(context),
                  icon: const Icon(Icons.logout, color: Colors.white, size: 28),
                  tooltip: 'Keluar Aplikasi',
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          
          // --- SUBTITLE ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Riwayat semua tindakan yang dilakukan oleh admin, petugas, dan peminjam',
              style: TextStyle(
                color: Color(0xFF5D3216),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // --- LIST DATA AKTIVITAS ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                _buildActivityCard(
                  role: "PETUGAS",
                  date: "01 Januari 2026",
                  desc: "Pengajuan peminjaman atas nama Cantika cantik\nkami setujui yaitu layar Proyektor",
                  status: "Pengajuan",
                  statusColor: accentGreen,
                  icon: Icons.check_circle_outline,
                ),
                _buildActivityCard(
                  role: "PEMINJAM",
                  date: "10 Januari 2026",
                  desc: "Mengajukan pinjaman atas nama Upin ardiansyah\nuntuk Presentasi",
                  status: "Proses",
                  statusColor: accentOrange,
                  icon: Icons.history,
                  isUnderlined: true,
                ),
                _buildActivityCard(
                  role: "ADMIN",
                  date: "02 Februari 2026",
                  desc: "Memberi keputusan untuk petugas yang mengajukan pinjaman",
                  status: "Persetujuan",
                  statusColor: accentGreen,
                  icon: Icons.check_circle_outline,
                ),
                const SizedBox(height: 20), // Padding bawah agar tidak tertutup navbar
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET CARD AKTIVITAS ---
  Widget _buildActivityCard({
    required String role,
    required String date,
    required String desc,
    required String status,
    required Color statusColor,
    required IconData icon,
    bool isUnderlined = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: espresso,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: vanilla, size: 26),
                  const SizedBox(width: 12),
                  Text(
                    role,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: isUnderlined ? TextDecoration.underline : null,
                      decorationColor: Colors.blue,
                      decorationThickness: 2,
                    ),
                  ),
                ],
              ),
              // Badge Status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor, width: 1.5),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor, 
                    fontSize: 11, 
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(date, style: TextStyle(color: vanilla, fontSize: 13)),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 13, 
              height: 1.4
            ),
          ),
        ],
      ),
    );
  }
}