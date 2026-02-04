import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sipena/auth/widget/admin_navbarr.dart';

class ManagementUserPage extends StatefulWidget {
  const ManagementUserPage({super.key});

  @override
  State<ManagementUserPage> createState() => _ManagementUserPageState();
}

class _ManagementUserPageState extends State<ManagementUserPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  
  // Warna Tema
  final Color espresso = const Color(0xFF5D3216);
  final Color vanilla = const Color(0xFFD9C5B2);
  final Color background = const Color(0xFFC9B097);

  // Controller untuk Tambah User
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  String _selectedRole = 'petugas';

  // Stream data dari tabel 'user'
  final Stream<List<Map<String, dynamic>>> _userStream =
      Supabase.instance.client.from('user').stream(primaryKey: ['id']).order('nama');

  // --- FUNGSI TAMBAH USER (AUTH + DATABASE) ---
  Future<void> _registerUser() async {
    try {
      // 1. Buat Akun di Supabase Authentication
      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (res.user != null) {
        // 2. Masukkan data profil ke tabel 'user'
        await supabase.from('user').insert({
          'id': res.user!.id, // UUID yang sama dengan Auth
          'nama': _namaController.text.trim(),
          'nomor_hp': _hpController.text.trim(),
          'role': _selectedRole,
        });

        if (mounted) {
          Navigator.pop(context);
          _clearForm();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User berhasil didaftarkan!")),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal: $e")),
      );
    }
  }

  // --- FUNGSI HAPUS USER ---
  Future<void> _deleteUser(String id) async {
    try {
      // Catatan: Supabase Free Tier tidak mengizinkan hapus Auth dari client-side dengan mudah.
      // Kode ini akan menghapus data di tabel 'user'.
      await supabase.from('user').delete().eq('id', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data user dihapus dari database")),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void _clearForm() {
    _emailController.clear();
    _passwordController.clear();
    _namaController.clear();
    _hpController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: const AdminNavbar(currentIndex: 2), // Sesuaikan index navbar admin kamu
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 25, left: 20),
            decoration: BoxDecoration(
              color: espresso,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: const Text(
              'Manajemen\nUser',
              style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.1),
            ),
          ),

          const SizedBox(height: 15),

          // Tombol Tambah User
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: _showAddUserForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: espresso,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.person_add, color: Colors.white),
              label: const Text("TAMBAH USER BARU", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),

          const SizedBox(height: 15),

          // List User Real-time
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _userStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Belum ada data user"));
                }

                final users = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final u = users[index];
                    return Card(
                      color: vanilla,
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: espresso,
                          child: Text(u['role'][0].toUpperCase(), style: const TextStyle(color: Colors.white)),
                        ),
                        title: Text(u['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text("${u['role']} | ${u['nomor_hp']}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteUser(u['id']),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- MODAL FORM TAMBAH ---
  void _showAddUserForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: background, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Registrasi User Baru", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                _buildField(_namaController, "Nama Lengkap", Icons.person),
                const SizedBox(height: 10),
                _buildField(_emailController, "Email", Icons.email),
                const SizedBox(height: 10),
                _buildField(_passwordController, "Password", Icons.lock, isObscure: true),
                const SizedBox(height: 10),
                _buildField(_hpController, "No. HP", Icons.phone, isPhone: true),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: _selectedRole,
                  decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                  items: ['admin', 'petugas', 'penyewa'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                  onChanged: (val) => setState(() => _selectedRole = val.toString()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: espresso, minimumSize: const Size(double.infinity, 50)),
                  onPressed: _registerUser,
                  child: const Text("DAFTARKAN SEKARANG", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, {bool isObscure = false, bool isPhone = false}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
      ),
    );
  }
}