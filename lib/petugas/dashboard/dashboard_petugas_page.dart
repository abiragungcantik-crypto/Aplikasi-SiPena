import 'package:flutter/material.dart';
import 'package:sipena/petugas/navbarr/petuugas_navbarr.dart';
import 'package:sipena/log out/log out.dart';

class DashboardPetugasPage extends StatefulWidget {
  const DashboardPetugasPage({super.key});

  @override
  State<DashboardPetugasPage> createState() => _DashboardPetugasPageState();
}

class _DashboardPetugasPageState extends State<DashboardPetugasPage> {
  // Warna Tema (Sesuaikan dengan Admin agar seragam)
  final Color espresso = const Color(0xFF5D3216);
  final Color vanilla = const Color(0xFFD9C5B2);
  final Color background = const Color(0xFFC9B097);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER DASHBOARD PETUGAS ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20, bottom: 25, left: 20, right: 15),
              decoration: BoxDecoration(
                color: espresso,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'PETUGAS',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 26, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  // Tombol Logout di Header
                  IconButton(
                    onPressed: () => AuthService.logout(context),
                    icon: const Icon(Icons.logout, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- KONTEN UTAMA ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Grid Statistik Singkat
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.4,
                      children: [
                        _buildStatCard("Total User", "20", Icons.people),
                        _buildStatCard("Total Alat", "10", Icons.inventory),
                        _buildStatCard("Tersedia", "5", Icons.check_circle),
                        _buildStatCard("Dipinjam", "5", Icons.pending_actions),
                      ],
                    ),
                    
                    const SizedBox(height: 25),
                    
                    // Daftar Notifikasi / Tugas Terbaru
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Peminjaman Terbaru",
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold, 
                          color: Color(0xFF5D3216)
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildTaskItem("Proyektor Epson", "Peminjam: petugas@gmail.com"),
                    _buildTaskItem("Layar Proyektor", "Peminjam: penyewa@gmail.com"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Kartu Statistik
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: espresso,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: vanilla, size: 30),
          const SizedBox(height: 5),
          Text(title, style: TextStyle(color: vanilla, fontSize: 12)),
          Text(
            value, 
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 22, 
              fontWeight: FontWeight.bold
            )
          ),
        ],
      ),
    );
  }

  // Widget List Item Tugas
  Widget _buildTaskItem(String title, String sub) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: vanilla.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.pending, color: espresso),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(sub),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Navigasi ke detail persetujuan jika perlu
        },
      ),
    );
  }
}