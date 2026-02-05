import 'package:flutter/material.dart';

// --- PALETTE WARNA (Bisa kamu pindahkan ke file core/theme kamu) ---
class AppColors {
  static const Color primaryDark = Color(0xFF4E342E); // Cokelat sangat tua
  static const Color background = Color(0xFFC5A381); // Cokelat medium
  static const Color cardBg = Color(0xFFD9B99B);    // Cokelat muda
  static const Color textDark = Color(0xFF3E2723);  // Warna teks gelap
}

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({super.key});

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  int _currentTab = 0; // Index untuk filter: 0=Diproses, 1=Diterima, 2=Ditolak

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // Header yang menyatu dengan status bar
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          "Dashboard\nPetugas",
          style: TextStyle(fontSize: 14, color: Colors.white, height: 1.2),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Text(
            "PROSES PERSETUJUAN",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          
          // Row Filter Tab (Diproses, Diterima, Ditolak)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabItem("Diproses", 0),
                _buildTabItem("Diterima", 1),
                _buildTabItem("Ditolak", 2),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: AppColors.primaryDark, thickness: 1.5),
          ),

          // Area List Data
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 4, 
              itemBuilder: (context, index) {
                // Sesuai data di database: Tabel Peminjaman & User
                return _ApprovalCard(
                  nama: "Cantika Cantiku",
                  role: "karyawan",
                  alat: "Layar Proyektor",
                  tanggal: "26 Januari 2026",
                  activeTab: _currentTab,
                );
              },
            ),
          ),
        ],
      ),
      // Navigasi Bawah sesuai Gambar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: 1, // Focus pada icon Pinjaman
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Pinjaman'),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: 'Kembali'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Laporan'),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    bool isActive = _currentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.primaryDark.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// --- PRIVATE WIDGET UNTUK CARD (MODULAR) ---
class _ApprovalCard extends StatelessWidget {
  final String nama;
  final String role;
  final String alat;
  final String tanggal;
  final int activeTab;

  const _ApprovalCard({
    required this.nama,
    required this.role,
    required this.alat,
    required this.tanggal,
    required this.activeTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryDark.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primaryDark,
                    child: Icon(Icons.person, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(role, style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ],
              ),
              Text(tanggal, style: const TextStyle(fontSize: 10)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 46, top: 4),
            child: Text("Layar Proyektor", style: TextStyle(fontSize: 13)),
          ),
          const SizedBox(height: 12),
          
          // Logika Tombol Sesuai Status di Gambar
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _buildButtons(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildButtons() {
    // Tombol menyesuaikan tab yang dipilih
    if (activeTab == 0) { // Tab Diproses
      return [
        _actionButton("tidak diterima", false),
        const SizedBox(width: 8),
        _actionButton("diterima", true),
      ];
    } else if (activeTab == 1) { // Tab Diterima
      return [_actionButton("diterima", true)];
    } else { // Tab Ditolak
      return [_actionButton("tidak diterima", false)];
    }
  }

  Widget _actionButton(String label, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primaryDark : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryDark),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isPrimary ? Colors.white : AppColors.primaryDark,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}