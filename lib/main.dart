import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import Auth & Common
import 'auth/login_page.dart';

// Import Admin Pages
import 'dashboard/dashboard_admin_page.dart';
<<<<<<< HEAD
import 'alat pinjaman/aalat_pinjaman_page.dart';
=======
import 'alat/alat_pinjaman_page.dart';
import 'management peminjaman/peminjaman_page.dart';
import 'aktiviitas/aktivitas_page.dart';
import 'kategori/kategori_alat_page.dart';
import 'user/admin_management_user.dart';

import 'petugas/dashboard/dashboard_petugas_page.dart';
import 'petugas/persetujuan/proses_persetujuan_screen.dart';
import 'kategori/kategori_alat_page.dart';
>>>>>>> b0cc0fc (belum)

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kllfdittpmvuekkwaebl.supabase.co',
<<<<<<< HEAD
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtsbGZkaXR0cG12dWVra3dhZWJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzMDMwNjgsImV4cCI6MjA4Mzg3OTA2OH0.tl0YPOPGQSBTOROoY9_TFev3lvlAySKva8-Af4xSJwU',
=======
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtsbGZkaXR0cG12dWVra3dhZWJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzMDMwNjgsImV4cCI6MjA4Mzg3OTA2OH0.tl0YPOPGQSBTOROoY9_TFev3lvlAySKva8-Af4xSJwU',
>>>>>>> b0cc0fc (belum)
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: Supabase.instance.client.auth.currentSession == null
          ? const LoginPage()
          : const AlatPinjamanPage(),
=======
      title: 'SIPENA',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.brown,
      ),
      
      // Halaman pertama yang muncul saat aplikasi dibuka
      home: const LoginPage(),

      // DAFTAR ROUTES (ALAMAT HALAMAN)
      routes: {
        // Routes untuk AUTH
        '/login': (context) => const LoginPage(),

        // Routes untuk ADMIN
        '/dashboard_admin': (context) => const DashboardAdminPage(),
        '/alat_admin': (context) => const AlatPage(), // Sesuaikan nama class di file kamu
        '/peminjaman_admin': (context) => const PeminjamanPage(),
        '/aktivitas_admin': (context) => const LogAktivitasPage(),
        '/kategori_admin': (context) => const KategoriPage(),
        '/management_user': (context) => const ManagementUserPage(),

        // Routes untuk PETUGAS
        '/dashboard_petugas': (context) => const DashboardPetugasPage(),
        '/persetujuan_petugas': (context) => const ProsesPersetujuanScreen(),
        // Tambahkan route alat petugas jika filenya berbeda
      },
>>>>>>> b0cc0fc (belum)
    );
  }
}