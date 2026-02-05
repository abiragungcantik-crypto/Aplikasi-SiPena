import 'package:flutter/material.dart';

// Gunakan konstanta warna yang sama dengan MainPetugasScreen agar senada
const Color primaryBrown = Color(0xFF6D3C18);
const Color bgBrown = Color(0xFFD9C0A7);
const Color secondaryBrown = Color(0xFFE2D1C1);

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({super.key});

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  int _currentTab = 0; // 0=Diproses, 1=Diterima, 2=Ditolak

  @override
  Widget build(BuildContext context) {
    // JANGAN gunakan Scaffold di sini karena sudah ada di MainPetugasScreen
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "PROSES PERSETUJUAN",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryBrown,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 15),
        
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
          child: Divider(color: primaryBrown, thickness: 1.5),
        ),

        // Area List Data
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: 3, // Sesuaikan dengan jumlah data nanti
            itemBuilder: (context, index) {
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
    );
  }

  Widget _buildTabItem(String label, int index) {
    bool isActive = _currentTab == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? secondaryBrown : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: primaryBrown,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: secondaryBrown.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryBrown.withOpacity(0.2)),
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
                    backgroundColor: primaryBrown,
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(role, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
              Text(tanggal, style: const TextStyle(fontSize: 10, color: Colors.black45)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, top: 5),
            child: Text(alat, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 15),
          
          // Tombol Aksi sesuai Tab
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _buildButtons(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildButtons() {
    if (activeTab == 0) { // Tab Diproses
      return [
        _actionButton("tidak diterima", false),
        const SizedBox(width: 10),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isPrimary ? primaryBrown : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryBrown),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isPrimary ? Colors.white : primaryBrown,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}