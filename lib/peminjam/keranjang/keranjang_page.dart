import 'package:flutter/material.dart';
import 'package:sipena/petugas/navbarr/petuugas_navbarr.dart';


class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: primaryBrown.withOpacity(0.5)),
          const SizedBox(height: 15),
          const Text(
            "Halaman Keranjang Kosong",
            style: TextStyle(color: primaryBrown, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}