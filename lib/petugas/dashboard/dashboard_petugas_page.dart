import 'package:flutter/material.dart';
import 'package:sipena/petugas/Pengembalian/penngembalian_page.dart';
import 'package:sipena/petugas/laporaan/laporan_petugas_page.dart';
import 'package:sipena/petugas/persetujuan/proses_persetujuan_screen.dart';

class MainPetugas extends StatefulWidget {
  const MainPetugas({super.key});

  @override
  State<MainPetugas> createState() => _MainPetugasState();
}

class _MainPetugasState extends State<MainPetugas> {
  // 1. Variabel index untuk memantau halaman mana yang aktif
  int _selectedIndex = 0;

final List<Widget> _pages = [
    const MainPetugas(), // Index 0 (Home)
    const ApprovalPage(),     // Index 1 (Pinjaman)
    const KembaliPage(),      // Index 2 (Kembali)
    const LaporanPage(),      // Index 3 (Laporan)
  ];
  final Color primaryBrown = const Color(0xFF6D3C18);
  final Color bgBrown = const Color(0xFFD9C0A7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBrown,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryBrown,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: const Text(
                'Dashboard\nPetugas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  // Grid Statistics
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatCard('Total user', '20', Icons.people_alt_rounded),
                      _buildStatCard('Total alat', '10', Icons.inventory_2_rounded),
                      _buildStatCard('Tersedia', '5', Icons.check_circle_outline_rounded),
                      _buildStatCard('Dipinjam', '5', Icons.warning_amber_rounded),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: primaryBrown,
                      hintText: 'Cari Nama User',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.search, color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Notifikasi Terbaru',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D3011),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Notification Cards
                  _buildNotificationCard(
                    name: 'Cantika Cantiku',
                    role: 'karyawan',
                    date: '28 Januari 2026',
                    notif: 'Peminjaman Layar Proyektor',
                    status: 'tidak diterima',
                    reason: 'Alat tidak tersedia pada waktu yang diminta',
                    isApproved: false,
                  ),
                  const SizedBox(height: 15),
                  _buildNotificationCard(
                    name: 'Muhammad Raju',
                    role: 'Guru',
                    date: '01 Januari 2026',
                    notif: 'Peminjaman Proyektor',
                    status: 'disetujui',
                    isApproved: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryBrown,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
              Icon(icon, color: Colors.white70, size: 20),
            ],
          ),
          Text(count, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String name,
    required String role,
    required String date,
    required String notif,
    required String status,
    String? reason,
    required bool isApproved,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: primaryBrown.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: primaryBrown, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(role, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                  ],
                ),
              ),
              Text(date, style: const TextStyle(fontSize: 10, color: Colors.black45)),
            ],
          ),
          const SizedBox(height: 10),
          Text('Notifikasi : $notif', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isApproved ? primaryBrown : const Color(0xFFE2D1C1),
                borderRadius: BorderRadius.circular(8),
                boxShadow: isApproved ? null : [const BoxShadow(blurRadius: 2, color: Colors.black26, offset: Offset(0, 2))],
              ),
              child: Text(
                status,
                style: TextStyle(color: isApproved ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          if (reason != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
                const SizedBox(width: 5),
                Text(reason, style: const TextStyle(color: Colors.red, fontSize: 11)),
              ],
            )
          ]
        ],
      ),
    );
  }
Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFF6D3C18), // primaryBrown
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
    // Mengecek apakah tombol ini yang sedang dipilih
    bool isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        // Fungsi utama: merubah halaman saat diklik
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFE2D1C1) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon, 
              color: isActive ? const Color(0xFF6D3C18) : Colors.white
            ),
          ),
          Text(
            label, 
            style: const TextStyle(color: Colors.white, fontSize: 10)
          ),
        ],
      ),
    );
  }
}