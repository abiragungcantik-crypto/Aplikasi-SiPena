import 'package:flutter/material.dart';
import 'package:sipena/petugas/navbarr/petuugas_navbarr.dart';

class InfoPengembalianPage extends StatelessWidget {
  const InfoPengembalianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _buildReturnCard("Layar proyektor", "Dipinjam", Colors.green),
        _buildReturnCard("Layar proyektor", "Terlambat", Colors.red),
      ],
    );
  }

  Widget _buildReturnCard(String title, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
                child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Tgl Pinjam : 01 Januari 2026", style: TextStyle(fontSize: 11)),
          const Text("Tgl Kembali : 02 Januari 2026", style: TextStyle(fontSize: 11)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBrown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Ajukan Pengembalian", style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }
}