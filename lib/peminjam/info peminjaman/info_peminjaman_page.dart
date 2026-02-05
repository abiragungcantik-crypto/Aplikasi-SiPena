import 'package:flutter/material.dart';

class InfoPeminjamanPage extends StatelessWidget {
  const InfoPeminjamanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildStatusCard("Layar proyektor", "Menunggu Persetujuan", Colors.brown),
        _buildStatusCard("Proyektor", "Ditolak", Colors.red),
        _buildStatusCard("Papan Tulis", "Dikembalikan", Colors.black54),
      ],
    );
  }

  Widget _buildStatusCard(String title, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Text("Tgl Pinjam : 01 Januari 2026", style: TextStyle(fontSize: 10)),
              const Text("Tgl Kembali : 02 Januari 2026", style: TextStyle(fontSize: 10)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}