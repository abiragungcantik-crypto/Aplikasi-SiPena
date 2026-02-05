import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// --- IMPORT AUTH & LAINNYA ---
import 'auth/login_page.dart';

// --- IMPORT MODULAR PEMINJAM (Pastikan path-nya benar) ---
// Sesuaikan dengan letak file yang kamu buat tadi
import 'package:sipena/peminjam/daftar alat/daftar_alat_page.dart';
import 'package:sipena/peminjam/dashboard/dashboard_page.dart';
import 'package:sipena/peminjam/info peminjaman/info_peminjaman_page.dart';
import 'package:sipena/peminjam/info pengembalian/info_pengembalian_page.dart';
import 'package:sipena/peminjam/keranjang/keranjang_page.dart';
import 'package:sipena/peminjam/navbar peminjam/navbar_peminjam_page.dart';



// --- IMPORT ADMIN & PETUGAS ---
import 'admin/dashboard/dashboard_admin_page.dart';
import 'admin/alat/tambah_alat_page.dart';
import 'admin/management peminjaman/peminjaman_page.dart';
import 'admin/aktiviitas/aktivitas_page.dart';
import 'admin/kategori/kategori_alat_page.dart';
import 'user/admin_management_user.dart';
import 'package:sipena/petugas/Pengembalian/penngembalian_page.dart';
import 'package:sipena/petugas/laporaan/laporan_petugas_page.dart';
import 'petugas/dashboard/dashboard_petugas_page.dart';
import 'petugas/persetujuan/proses_persetujuan_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kllfdittpmvuekkwaebl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtsbGZkaXR0cG12dWVra3dhZWJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzMDMwNjgsImV4cCI6MjA4Mzg3OTA2OH0.tl0YPOPGQSBTOROoY9_TFev3lvlAySKva8-Af4xSJwU', // Gunakan key lengkapmu
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIPENA',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.brown,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D3216),
          primary: const Color(0xFF6D3C18), // Warna cokelat navbar
        ),
      ),

      // PANGGIL HALAMAN PEMINJAM DI SINI
      // Ganti ApprovalPage() dengan PeminjamNavbar()
      home: const LoginPage(),
      // Jika nanti ingin menggunakan logika login:
      // home: Supabase.instance.client.auth.currentSession == null
      //     ? const LoginPage()
      //     : const PeminjamNavbar(),
    );
  }
}