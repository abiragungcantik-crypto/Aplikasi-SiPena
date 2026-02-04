import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../alat pinjaman/aalat_pinjaman_page.dart';
=======
import 'package:sipena/auth/widget/admin_navbarr.dart';
import 'package:sipena/alat/alat_pinjaman_page.dart';
import 'package:sipena/aktiviitas/aktivitas_page.dart';

>>>>>>> b0cc0fc (belum)

class DashboardAdminPage extends StatelessWidget {
  const DashboardAdminPage({super.key});

  static const bgColor = Color(0xFFE6D0B8);
  static const primary = Color(0xFF7A4516);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

<<<<<<< HEAD
      // ===== BOTTOM NAVBAR =====
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: primary,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Alat"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "User"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Aktivitas",
          ),
        ],
      ),
=======
      // ✅ NAVBAR DIPANGGIL DARI FILE TERPISAH
      bottomNavigationBar: const AdminNavbar(currentIndex: 0),
>>>>>>> b0cc0fc (belum)

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
<<<<<<< HEAD
                    Text(
                      "Dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Admin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
=======
                    Text("Dashboard",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(height: 4),
                    Text("Admin",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
>>>>>>> b0cc0fc (belum)
                  ],
                ),
              ),

              const SizedBox(height: 14),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Ringkasan sistem penyewaan",
<<<<<<< HEAD
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
=======
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: primary),
>>>>>>> b0cc0fc (belum)
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: const [
                    SummaryCard("Total user", "20", Icons.person),
                    SummaryCard("Total alat", "10", Icons.inventory),
                    SummaryCard("Tersedia", "5", Icons.check_circle_outline),
                    SummaryCard("Dipinjam", "5", Icons.warning_amber_outlined),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Divider(color: primary),

              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Daftar Riwayat",
<<<<<<< HEAD
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
=======
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: primary),
>>>>>>> b0cc0fc (belum)
                ),
              ),

              const HistoryItem(
                  "Peminjaman Alat 01", "01 Januari 2025, 09.00"),
              const HistoryItem(
                  "Peminjaman Alat 02", "02 Januari 2025, 10.00"),
              const HistoryItem(
                  "Peminjaman Alat 03", "03 Januari 2025, 12.00"),

              const SizedBox(height: 16),
              const Divider(color: primary),

              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Klik disini",
<<<<<<< HEAD
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
=======
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: primary),
>>>>>>> b0cc0fc (belum)
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
<<<<<<< HEAD
                    _ActionButton(
                      icon: Icons.keyboard_return,
                      label: "Pengembalian",
                    ),
                    SizedBox(height: 10),
                    _ActionButton(icon: Icons.assignment, label: "Peminjaman"),
=======
                    ActionButton(
                        icon: Icons.keyboard_return,
                        label: "Pengembalian"),
                    SizedBox(height: 10),
                    ActionButton(
                        icon: Icons.assignment,
                        label: "Peminjaman"),
>>>>>>> b0cc0fc (belum)
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== KOMPONEN =====
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SummaryCard(this.title, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: DashboardAdminPage.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          const Spacer(),
<<<<<<< HEAD
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
=======
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
>>>>>>> b0cc0fc (belum)
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String title;
  final String date;

  const HistoryItem(this.title, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DashboardAdminPage.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
<<<<<<< HEAD
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
=======
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(date,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
>>>>>>> b0cc0fc (belum)
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: DashboardAdminPage.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
