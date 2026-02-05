import 'package:flutter/material.dart';
import 'package:sipena/petugas/navbarr/petuugas_navbarr.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Grid Statistik
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildStatCard("Total user", "20", Icons.person),
              _buildStatCard("Total alat", "10", Icons.inventory_2),
              _buildStatCard("Tersedia", "5", Icons.check_circle),
              _buildStatCard("Dipinjam", "5", Icons.warning),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            "KATEGORI",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primaryBrown),
          ),
          const SizedBox(height: 15),
          _buildCategoryButton("Alat Presentasi"),
          _buildCategoryButton("Alat Pembelajaran"),
          _buildCategoryButton("Alat print"),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryBrown,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Icon(icon, color: Colors.white.withOpacity(0.5), size: 20),
            ],
          ),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBrown,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }
}