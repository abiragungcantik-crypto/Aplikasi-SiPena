import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            // Menggunakan CustomHeader yang didefinisikan di bawah
            CustomHeader(title: _titles[_selectedIndex]),
            
            // Area Konten Dinamis
            Expanded(
              child: _buildPage(_selectedIndex),
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

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const Center(child: Text("Halaman Dashboard")); 
      case 1:
        return const ApprovalContent(); 
      case 2:
        return const KembaliPageContent(); 
      case 3:
        return const Center(child: Text("Halaman Laporan"));
      default:
        return const Center(child: Text("Halaman Tidak Ditemukan"));
    }
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

// --- KONTEN HALAMAN KEMBALI ---
class KembaliPageContent extends StatelessWidget {
  const KembaliPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'DAFTAR PENGEMBALIAN',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryBrown),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              _buildCard('Cantika Cantiku', 'Layar Proyektor'),
              _buildCard('Muhammad Raju', 'Scanner'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String name, String item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondaryBrown.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryBrown.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: primaryBrown, 
            child: Icon(Icons.person, color: Colors.white)
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(item, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

// --- KONTEN HALAMAN APPROVAL ---
class ApprovalContent extends StatelessWidget {
  const ApprovalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Konten Persetujuan di sini",
        style: TextStyle(color: primaryBrown, fontWeight: FontWeight.bold),
      ),
    );
  }
}