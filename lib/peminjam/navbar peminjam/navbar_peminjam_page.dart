import 'package:flutter/material.dart';
import 'package:sipena/petugas/navbarr/petuugas_navbarr.dart';

// Import halaman-halaman peminjam kamu
import 'package:sipena/peminjam/daftar alat/daftar_alat_page.dart';
import 'package:sipena/peminjam/dashboard/dashboard_page.dart';
import 'package:sipena/peminjam/info peminjaman/info_peminjaman_page.dart';
import 'package:sipena/peminjam/info pengembalian/info_pengembalian_page.dart';
import 'package:sipena/peminjam/keranjang/keranjang_page.dart';

class PeminjamNavbar extends StatefulWidget {
  const PeminjamNavbar({super.key});

  @override
  State<PeminjamNavbar> createState() => _PeminjamNavbarState();
}

class _PeminjamNavbarState extends State<PeminjamNavbar> {
  int _selectedIndex = 0;

  // Judul yang akan tampil di Header sesuai halaman yang dipilih
  final List<String> _titles = [
    'Dashboard Peminjam',
    'Daftar Alat Tersedia',
    'Informasi Peminjaman',
    'Informasi Pengembalian',
    'Keranjang Pinjaman',
  ];

  final List<Widget> _pages = [
    const DashboardPage(),
    const DaftarAlatPage(),
    const InfoPeminjamanPage(),
    const InfoPengembalianPage(),
    const KeranjangPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER PEMINJAM ---
            _buildPeminjamHeader(_titles[_selectedIndex]),
            
            // --- KONTEN HALAMAN ---
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // Widget Header Modular
  Widget _buildPeminjamHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        color: primaryBrown,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SIPENA",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Navigasi Bawah sesuai gambar yang kamu kirim
  Widget _buildBottomNavBar() {
    return Container(
      height: 85,
      decoration: const BoxDecoration(color: primaryBrown),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_filled, Icons.home_outlined, "Home", 0),
          _navItem(Icons.email, Icons.email_outlined, "Daftar Alat", 1),
          _navItem(Icons.assignment, Icons.assignment_outlined, "Pinjaman", 2),
          _navItem(Icons.assignment_returned, Icons.assignment_returned_outlined, "Kembali", 3),
          _navItem(Icons.shopping_cart, Icons.shopping_cart_outlined, "Keranjang", 4),
        ],
      ),
    );
  }

  Widget _navItem(IconData activeIcon, IconData inactiveIcon, String label, int index) {
    bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFE2D1C1) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isActive ? activeIcon : inactiveIcon,
              color: isActive ? primaryBrown : const Color(0xFFE2D1C1),
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFFE2D1C1),
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}