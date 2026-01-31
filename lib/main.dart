import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth/login_page.dart';
import 'dashboard/dashboard_admin_page.dart';
import 'alat pinjaman/aalat_pinjaman_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kllfdittpmvuekkwaebl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtsbGZkaXR0cG12dWVra3dhZWJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgzMDMwNjgsImV4cCI6MjA4Mzg3OTA2OH0.tl0YPOPGQSBTOROoY9_TFev3lvlAySKva8-Af4xSJwU',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Supabase.instance.client.auth.currentSession == null
          ? const LoginPage()
          : const AlatPinjamanPage(),
    );
  }
}
