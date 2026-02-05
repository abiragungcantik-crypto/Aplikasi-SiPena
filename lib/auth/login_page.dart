import 'package:flutter/material.dart';
import 'package:sipena/peminjam/dashboard/dashboard_page.dart';
import 'package:sipena/petugas/navbarr/petuugas_navbarr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sipena/admin/dashboard/dashboard_admin_page.dart';

import '../peminjam/navbar peminjam/navbar_peminjam_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;

  Future<void> _handleLogin() async {
    // Validasi input kosong
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorBanner("Input Kosong", "Silakan masukkan email dan password");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Login ke Supabase Auth
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final authUser = res.user;
      if (authUser == null) throw Exception("User tidak ditemukan");

      // 2. Ambil data role dari tabel 'user' berdasarkan auth_user_id
      final userData = await Supabase.instance.client
          .from('user')
          .select('role')
          .eq('auth_user_id', authUser.id)
          .single();

      final actualRole = userData['role'].toString().toLowerCase();

      if (!mounted) return;

      // 3. Navigasi Otomatis Berdasarkan Role dari Database
      if (actualRole == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardAdminPage()),
        );
      } else if (actualRole == 'petugas') {
        // Ganti dengan Class Wrapper/Dashboard petugas yang sesuai
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainPetugasScreen()),
        );
      } else if (actualRole == 'peminjam') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PeminjamNavbar()),
        );
      } else {
        throw Exception("Role tidak dikenali");
      }
    } catch (e) {
      // Cetak error asli ke console untuk debugging
      print("DEBUG_ERROR: $e");

      if (e is AuthException) {
        _showErrorBanner(
          "Gagal Login",
          e.message,
        ); // Menampilkan pesan asli dari Supabase
      } else {
        _showErrorBanner("Gagal Login", "Terjadi kesalahan sistem");
      }
    }
  }

  void _showErrorBanner(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.redAccent),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9C2A6),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/sipena.jpg',
                  height: 120,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Color(0xFF6F3F1E),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              _buildFieldLabel("Email"),
              const SizedBox(height: 8),
              _buildTextField(_emailController, "masukkan email", false),

              const SizedBox(height: 16),

              _buildFieldLabel("Password"),
              const SizedBox(height: 8),
              _buildTextField(_passwordController, "masukkan password", true),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3F1E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'MASUK',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6F3F1E),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    bool isPass,
  ) {
    return TextField(
      controller: controller,
      obscureText: isPass ? _obscureText : false,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFEAD7C2),
        suffixIcon: isPass
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF6F3F1E),
                ),
                onPressed: () => setState(() => _obscureText = !_obscureText),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
