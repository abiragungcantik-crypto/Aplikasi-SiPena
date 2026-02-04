import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sipena/auth/login_page.dart';


class AuthService {
  // Fungsi Logout Global
  static Future<void> logout(BuildContext context) async {
    try {
      // 1. Tampilkan Dialog Konfirmasi
      bool confirm = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Konfirmasi Keluar"),
          content: const Text("Apakah Anda yakin ingin keluar?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Keluar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ) ?? false;

      // 2. Jika user pilih Keluar
      if (confirm) {
        await Supabase.instance.client.auth.signOut();
        
        if (!context.mounted) return;

        // Pindah ke Login dan hapus semua halaman sebelumnya
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}