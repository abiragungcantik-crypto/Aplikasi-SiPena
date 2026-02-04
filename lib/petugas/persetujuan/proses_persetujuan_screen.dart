import 'package:flutter/material.dart';
import 'package:sipena/petugas/navbarr/petuugas_navbarr.dart';

class ProsesPersetujuanScreen extends StatelessWidget {
  const ProsesPersetujuanScreen({super.key});

  final Color primaryBrown = const Color(0xFF633413);
  final Color bgBeige = const Color(0xFFD2B48C);
  final Color cardBrown = const Color(0xFF5D3415);
  final Color chipColor = const Color(0xFF8B5E3C);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: bgBeige,
        body: SafeArea(
          child: Column(
            children: [
              // Header tetap konsisten
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: primaryBrown,
                child: const Text(
                  'Dashboard\nPetugas',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              
              const Text(
                'PROSES PERSETUJUAN',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF5D3415)),
              ),
              const SizedBox(height: 10),

              // Tab Bar Custom (Diproses, Diterima, Ditolak)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: primaryBrown, width: 1)),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: chipColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: primaryBrown,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(child: Text("Diproses", style: TextStyle(fontSize: 12))),
                      Tab(child: Text("Diterima", style: TextStyle(fontSize: 12))),
                      Tab(child: Text("Ditolak", style: TextStyle(fontSize: 12))),
                    ],
                  ),
                ),
              ),

              // Isi Tab
              Expanded(
                child: TabBarView(
                  children: [
                    _buildListContent('diproses'),
                    _buildListContent('diterima'),
                    _buildListContent('ditolak'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListContent(String status) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return _buildApprovalCard(status);
      },
    );
  }

  Widget _buildApprovalCard(String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: primaryBrown.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: cardBrown, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cantika Cantiku', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('karyawan', style: TextStyle(fontSize: 12)),
                    Text('Layar Proyektor', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const Text('26 Januari 2026', style: TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (status == 'diproses' || status == 'ditolak')
                _buildActionButton("tidak diterima", isOutline: true),
              const SizedBox(width: 10),
              if (status == 'diproses' || status == 'diterima')
                _buildActionButton("diterima", isOutline: false),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, {required bool isOutline}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isOutline ? Colors.transparent : cardBrown,
        borderRadius: BorderRadius.circular(8),
        border: isOutline ? Border.all(color: Colors.black) : null,
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Text(
        text,
        style: TextStyle(color: isOutline ? Colors.black : Colors.white, fontSize: 12),
      ),
    );
  }
}