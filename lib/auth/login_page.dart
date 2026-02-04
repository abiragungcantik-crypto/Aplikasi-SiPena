import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// Sesuaikan import ini dengan lokasi file Anda di VS Code
import 'package:sipena/dashboard/dashboard_admin_page.dart';
import 'package:sipena/petugas/dashboard/dashboard_petugas_page.dart';
// import 'package:sipena/PENYEWA/dashboard_penyewa_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Variabel Role
  String? _selectedRole; 
  final List<String> _roles = ['admin', 'petugas', 'penyewa'];

  bool _isLoading = false;
  bool _obscureText = true;

  Future<void> _handleLogin() async {
    if (_selectedRole == null) {
      _showErrorBanner("Pilih Role", "Silakan pilih role Anda terlebih dahulu");
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

      // 2. Cek Role di tabel 'user' database
      final userData = await Supabase.instance.client
          .from('user')
          .select('role')
          .eq('auth_user_id', authUser.id)
          .single();

      final actualRole = userData['role'];

      if (!mounted) return;

      // 3. Validasi: Apakah pilihan di UI sama dengan data di Database?
      if (actualRole.toString().toLowerCase() == _selectedRole!.toLowerCase()) {
        if (actualRole == 'admin') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardAdminPage()));
        } else if (actualRole == 'petugas') {
        } else if (actualRole == 'penyewa') {
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardPenyewaPage()));
        }
      } else {
        // Jika role tidak cocok, paksa logout demi keamanan
        await Supabase.instance.client.auth.signOut();
        _showErrorBanner("Akses Ditolak", "Role yang dipilih tidak sesuai dengan akun Anda");
      }
      
    } catch (e) {
      _showErrorBanner("Gagal Login", "Email atau Password salah");
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
            color: const Color(0xFFE5E5E5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              Text(message, style: const TextStyle(color: Colors.black54, fontSize: 12)),
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
              // LOGO (Menggunakan Image.asset sesuai VS Code Anda)
              Center(
                child: Image.asset(
                  'assets/images/sipena.jpg', 
                  height: 120,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 80),
                ),
              ),
              const SizedBox(height: 30),

              // DROPDOWN ROLE
              _buildFieldLabel("Pilih Role"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAD7C2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    value: _selectedRole,
                    hint: const Text("Pilih Akses"),
                    decoration: const InputDecoration(border: InputBorder.none),
                    items: _roles.map((role) => DropdownMenuItem(
                      value: role,
                      child: Text(role.toUpperCase(), style: const TextStyle(color: Color(0xFF6F3F1E))),
                    )).toList(),
                    onChanged: (val) => setState(() => _selectedRole = val),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // USERNAME
              _buildFieldLabel("Username / Email"),
              const SizedBox(height: 8),
              _buildTextField(_emailController, "masukkan email", false),

              const SizedBox(height: 16),

              // PASSWORD
              _buildFieldLabel("Password"),
              const SizedBox(height: 8),
              _buildTextField(_passwordController, "masukkan password", true),

              const SizedBox(height: 32),

              // BUTTON MASUK
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3F1E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('MASUK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF6F3F1E)));
  }

  Widget _buildTextField(TextEditingController controller, String hint, bool isPass) {
    return TextField(
      controller: controller,
      obscureText: isPass ? _obscureText : false,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFEAD7C2),
        suffixIcon: isPass ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF6F3F1E)),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }
}