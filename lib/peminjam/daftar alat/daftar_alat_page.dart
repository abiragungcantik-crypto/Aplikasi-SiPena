import 'package:flutter/material.dart';
import 'package:sipena/petugas/navbarr/petuugas_navbarr.dart';


class DaftarAlatPage extends StatelessWidget {
  const DaftarAlatPage({super.key});
  
  Color? get cardColor => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Cari Nama Alat",
              prefixIcon: const Icon(Icons.search, color: primaryBrown),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        // List Alat
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: 8, // Contoh jumlah data
            itemBuilder: (context, index) {
              return _buildAlatCard("Layar proyektor", "Alat Presentasi");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAlatCard(String name, String category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(category, style: const TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          ),
          Row(
            children: [
              const Text("Tersedia", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBrown,
                  minimumSize: const Size(70, 30),
                  padding: EdgeInsets.zero,
                ),
                child: const Text("Dipinjam", style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ],
          )
        ],
      ),
    );
  }
}