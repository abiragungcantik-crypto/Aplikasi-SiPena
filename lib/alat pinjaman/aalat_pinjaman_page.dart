import 'package:flutter/material.dart';

class AlatPinjamanPage extends StatefulWidget {
  const AlatPinjamanPage({super.key});

  @override
  State<AlatPinjamanPage> createState() => _AlatPinjamanPageState();
}

class _AlatPinjamanPageState extends State<AlatPinjamanPage> {
  static const bgColor = Color(0xFFE6D0B8);
  static const primary = Color(0xFF7A4516);

  void showTambahAlat() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tambah Alat",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              input("Nama Alat"),
              input("Stok", isNumber: true),

              dropdown(),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Batal"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primary,
                      ),
                      onPressed: () {},
                      child: const Text("Simpan"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget input(String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget dropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text("Kategori"),
          items: const [
            DropdownMenuItem(value: "Proyektor", child: Text("Proyektor")),
            DropdownMenuItem(value: "Laptop", child: Text("Laptop")),
            DropdownMenuItem(value: "Audio", child: Text("Audio")),
          ],
          onChanged: (_) {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Alat"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "User"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: "Aktivitas"),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER =====
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  const Text("Admin",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),

                  // Search
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.search),
                              hintText: "Cari Alat",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.tune),
                      )
                    ],
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton.icon(
                    onPressed: showTambahAlat,
                    icon: const Icon(Icons.add),
                    label: const Text("Tambah Alat"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ===== LIST =====
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  AlatCard("Proyektor", "Stok: 3", "Kategori: Presentasi"),
                  AlatCard("Proyektor", "Stok: 2", "Kategori: Presentasi"),
                  AlatCard("Proyektor", "Stok: 1", "Kategori: Presentasi"),
                  AlatCard("Proyektor", "Stok: 5", "Kategori: Presentasi"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== CARD ALAT =====
class AlatCard extends StatelessWidget {
  final String nama;
  final String stok;
  final String kategori;

  const AlatCard(this.nama, this.stok, this.kategori, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _AlatPinjamanPageState.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(stok,
                    style: const TextStyle(color: Colors.white70)),
                Text(kategori,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
