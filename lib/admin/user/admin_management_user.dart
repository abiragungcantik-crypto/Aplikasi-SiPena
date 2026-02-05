import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sipena/admin/widget/admin_navbarr.dart';

class ManagementUserPage extends StatefulWidget {
  const ManagementUserPage({super.key});

  @override
  State<ManagementUserPage> createState() => _ManagementUserPageState();
}

class _ManagementUserPageState extends State<ManagementUserPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  final Color espresso = const Color(0xFF5D3216);
  final Color vanilla = const Color(0xFFD9C5B2);
  final Color background = const Color(0xFFC9B097);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();

  String _selectedRole = 'petugas';
  bool _isLoading = false;

  late final Stream<List<Map<String, dynamic>>> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = supabase
        .from('user')
        .stream(primaryKey: ['id'])
        .order('nama');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _namaController.dispose();
    _hpController.dispose();
    super.dispose();
  }

  // ================= REGISTER USER =================
  Future<void> _registerUser() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _namaController.text.isEmpty) {
      _showSnackBar("Lengkapi semua data!");
      return;
    }

    try {
      setState(() => _isLoading = true);
      final Session? adminSession = supabase.auth.currentSession;

      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (res.user == null) throw "Gagal mendaftarkan autentikasi user.";

      final String newUserId = res.user!.id;

      if (adminSession != null) {
        await supabase.auth.setSession(adminSession.refreshToken!);
      }

      await supabase.from('user').insert({
        'auth_user_id': newUserId,
        'nama': _namaController.text.trim(),
        'nomor_hp': _hpController.text.trim(),
        'role': _selectedRole, // Role 'peminjam' sudah masuk sini dari dropdown
        'email': _emailController.text.trim(),
      });

      if (!mounted) return;
      Navigator.pop(context);
      _clearForm();
      _showSnackBar("User berhasil didaftarkan!");
    } catch (e) {
      _showSnackBar("Gagal simpan user: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ================= UPDATE USER =================
  Future<void> _updateUser(String id, String oldEmail) async {
    final newEmail = _emailController.text.trim();
    
    try {
      setState(() => _isLoading = true);

      // Pastikan baris email di bawah ini AKTIF
      await supabase.from('user').update({
        'nama': _namaController.text.trim(),
        'nomor_hp': _hpController.text.trim(),
        'role': _selectedRole,
        'email': newEmail, // <-- PASTIKAN INI AKTIF
      }).eq('id', id);

      if (!mounted) return;
      Navigator.pop(context);
      _clearForm();
      _showSnackBar("Data user berhasil diperbarui!");
    } catch (e) {
      _showSnackBar("Gagal update user: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ================= DELETE USER =================
  Future<void> _deleteUser(String id) async {
    try {
      await supabase.from('user').delete().eq('id', id);
      _showSnackBar("Data user berhasil dihapus");
    } catch (e) {
      _showSnackBar("Gagal menghapus user");
    }
  }

  void _clearForm() {
    _emailController.clear();
    _passwordController.clear();
    _namaController.clear();
    _hpController.clear();
    _selectedRole = 'petugas';
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: const AdminNavbar(currentIndex: 2),
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 15),
          _buildAddButton(),
          const SizedBox(height: 15),
          Expanded(child: _buildUserList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : () => _showUserForm(),
        style: ElevatedButton.styleFrom(
          backgroundColor: espresso,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text("TAMBAH USER BARU", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildUserList() {
  return StreamBuilder<List<Map<String, dynamic>>>(
    stream: _userStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
      if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
      if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text("Belum ada data user"));

      final users = snapshot.data!;
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final u = users[index];
          
          // Logika Inisial Nama: Ambil huruf pertama dari nama
          String inisial = "U";
          if (u['nama'] != null && u['nama'].toString().isNotEmpty) {
            inisial = u['nama'].toString()[0].toUpperCase();
          }

          return Card(
            color: vanilla,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: espresso,
                // Menampilkan inisial dari NAMA
                child: Text(inisial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              title: Text(u['nama'], style: const TextStyle(fontWeight: FontWeight.bold)),
              // Menampilkan Email di bawah Nama
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(u['email'] ?? "Email tidak tersedia", style: TextStyle(color: espresso.withOpacity(0.8), fontSize: 13)),
                  const SizedBox(height: 2),
                  Text("${u['role']} | ${u['nomor_hp']}", style: const TextStyle(fontSize: 12)),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showUserForm(user: u),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _confirmDelete(u['id'], u['nama']),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

  void _confirmDelete(String id, String nama) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus User"),
        content: Text("Hapus $nama secara permanen?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteUser(id);
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showUserForm({Map<String, dynamic>? user}) {
    final bool isEdit = user != null;
    String initialEmail = "";

    if (isEdit) {
      _namaController.text = user['nama'];
      _hpController.text = user['nomor_hp'];
      _selectedRole = user['role'];
      // Jika Anda menyimpan email di tabel public.user:
      _emailController.text = user['email'] ?? ""; 
      initialEmail = _emailController.text;
    } else {
      _clearForm();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: background,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isEdit ? "Edit User" : "Registrasi User Baru",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  _buildField(_namaController, "Nama Lengkap", Icons.person),
                  const SizedBox(height: 10),
                  
                  // SEKARANG EMAIL MUNCUL DI EDIT JUGA
                  _buildField(_emailController, "Email", Icons.email),
                  const SizedBox(height: 10),

                  if (!isEdit) ...[
                    _buildField(_passwordController, "Password", Icons.lock, isObscure: true),
                    const SizedBox(height: 10),
                  ],
                  _buildField(_hpController, "No. HP", Icons.phone, isPhone: true),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: const InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder()),
                    items: ['admin', 'petugas', 'peminjam']
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (val) {
                      setModalState(() => _selectedRole = val!);
                      setState(() => _selectedRole = val!);
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: espresso, minimumSize: const Size(double.infinity, 50)),
                    onPressed: _isLoading ? null : () {
                       if (isEdit) {
                         _updateUser(user['id'], initialEmail);
                       } else {
                         _registerUser();
                       }
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(isEdit ? "SIMPAN PERUBAHAN" : "DAFTARKAN SEKARANG", style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
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