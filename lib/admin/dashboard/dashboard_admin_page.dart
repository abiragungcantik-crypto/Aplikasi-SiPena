import 'package:flutter/material.dart';
import 'package:sipena/admin/widget/admin_navbarr.dart';
import 'package:sipena/user/admin_management_user.dart';

class DashboardAdminPage extends StatelessWidget {
  const DashboardAdminPage({super.key});

  // Tema Warna SIPENA
  static const Color bgColor = Color(0xFFC9B097);
  static const Color primary = Color(0xFF5D3216);
  static const Color vanilla = Color(0xFFD9C5B2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: const AdminNavbar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "ADMIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Ringkasan sistem penyewaan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: primary),
                ),
              ),

              const SizedBox(height: 15),

              // ===== GRID STATISTIK =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ManagementUserPage(),
                          ),
                        );
                      },
                      child:
                          const SummaryCard("Total user", "20", Icons.person),
                    ),
                    const SummaryCard("Total alat", "10", Icons.inventory),
                    const SummaryCard(
                        "Tersedia", "5", Icons.check_circle_outline),
                    const SummaryCard(
                        "Dipinjam", "5", Icons.warning_amber_outlined),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Daftar Riwayat Terbaru",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primary),
                ),
              ),

              const SizedBox(height: 10),

              const HistoryItem("Peminjaman Alat 01", "01 Januari 2026, 09.00"),
              const HistoryItem("Peminjaman Alat 02", "02 Januari 2026, 10.00"),
              const HistoryItem("Peminjaman Alat 03", "03 Januari 2026, 12.00"),

              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Aksi Cepat",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primary),
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
                    ActionButton(
                        icon: Icons.keyboard_return,
                        label: "Kelola Pengembalian"),
                    SizedBox(height: 10),
                    ActionButton(
                        icon: Icons.assignment,
                        label: "Kelola Peminjaman"),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== KOMPONEN SUMMARY CARD =====
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const SummaryCard(this.title, this.value, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DashboardAdminPage.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: DashboardAdminPage.vanilla, size: 28),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          Text(title,
              style: const TextStyle(
                  color: DashboardAdminPage.vanilla, fontSize: 12)),
        ],
      ),
    );
  }
}

// ===== KOMPONEN HISTORY ITEM =====
class HistoryItem extends StatelessWidget {
  final String title;
  final String date;

  const HistoryItem(this.title, this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DashboardAdminPage.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.history, color: DashboardAdminPage.primary),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: DashboardAdminPage.primary,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                style: const TextStyle(color: Colors.black54, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===== KOMPONEN ACTION BUTTON =====
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: DashboardAdminPage.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}
