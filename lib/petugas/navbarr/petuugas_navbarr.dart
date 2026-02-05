import 'package:flutter/material.dart';
import 'package:sipena/petugas/dashboard/dashboard_petugas_page.dart';
import 'package:sipena/petugas/persetujuan/proses_persetujuan_screen.dart';

import '../Pengembalian/penngembalian_page.dart';
import '../laporaan/laporan_petugas_page.dart';

// --- KONSTANTA WARNA ---
const Color primaryBrown = Color(0xFF6D3C18);
const Color bgBrown = Color(0xFFD9C0A7);
const Color secondaryBrown = Color(0xFFE2D1C1);

// --- MAIN SCREEN (SCREEN UTAMA) ---
class MainPetugasScreen extends StatefulWidget {
  const MainPetugasScreen({super.key});

  @override
  State<MainPetugasScreen> createState() => _MainPetugasScreenState();
}

class _MainPetugasScreenState extends State<MainPetugasScreen> {
  int _selectedIndex = 0;

  // Daftar Judul Header sesuai Halaman
  final List<String> _titles = [
    'Dashboard Petugas',
    'Persetujuan Pinjaman',
    'Riwayat Pengembalian',
    'Laporan Aktivitas',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBrown,
      // Di dalam build Scaffold
body: SafeArea(
  child: Column(
    children: [
      CustomHeader(title: _titles[_selectedIndex]),
      Expanded(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            MainPetugas(),
            ApprovalPage(),
            KembaliPage(),
            LaporanPage(),
          ],
        ),
      ),
    ],
  ),
),
      // Menggunakan CustomNavBar yang didefinisikan di bawah
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}

// --- MODULAR HEADER ---
class CustomHeader extends StatelessWidget {
  final String title;
  const CustomHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: primaryBrown,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// --- MODULAR NAVBAR ---
class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key, 
    required this.currentIndex, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(color: primaryBrown),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, 'Home', 0),
          _navItem(Icons.assignment_outlined, 'Pinjaman', 1),
          _navItem(Icons.assignment_return_outlined, 'Kembali', 2),
          _navItem(Icons.show_chart_outlined, 'Laporan', 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? secondaryBrown : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isActive ? primaryBrown : Colors.white),
          ),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }
}