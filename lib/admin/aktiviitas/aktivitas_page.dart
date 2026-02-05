import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase
import 'package:sipena/log out/log out.dart';
import 'package:sipena/admin/widget/admin_navbarr.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal (tambah di pubspec.yaml)

class LogAktivitasPage extends StatefulWidget {
  const LogAktivitasPage({super.key});

  @override
  State<LogAktivitasPage> createState() => _LogAktivitasPageState();
}

class _LogAktivitasPageState extends State<LogAktivitasPage> {
  // Instance Supabase
  final supabase = Supabase.instance.client;

  // Variabel Warna Tema
  final Color espresso = const Color(0xFF5D3216);
  final Color vanilla = const Color(0xFFD9C5B2);
  final Color background = const Color(0xFFC9B097);
  final Color accentGreen = const Color(0xFF99B898);
  final Color accentOrange = const Color(0xFFE5B181);

  // Fungsi untuk mengambil data dari tabel log_aktivitas
  Future<List<Map<String, dynamic>>> fetchLogs() async {
    final response = await supabase
        .from('log_aktivitas')
        .select()
        .order('created_at', ascending: false); // Urutkan dari yang terbaru
    return response as List<Map<String, dynamic>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: const AdminNavbar(currentIndex: 4),
      body: Column(
        children: [
          // --- HEADER ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 25, left: 20, right: 15),
            decoration: BoxDecoration(
              color: espresso,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Log\nAktivitas',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.1),
                ),
                IconButton(
                  onPressed: () => AuthService.logout(context),
                  icon: const Icon(Icons.logout, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- SUBTITLE ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Riwayat otomatis perubahan data',
              style: TextStyle(color: espresso, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          const SizedBox(height: 15),

          // --- LIST DATA DARI SUPABASE ---
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchLogs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada riwayat aktivitas.'));
                }

                final logs = snapshot.data!;

                return RefreshIndicator(
                  onRefresh: () async => setState(() {}), // Tarik ke bawah untuk refresh
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      
                      // Logika warna berdasarkan tipe aktivitas
                      Color statusColor;
                      IconData icon;
                      String aksi = log['aktivitas']?.toString().toUpperCase() ?? 'UNKNOWN';

                      if (aksi == 'INSERT') {
                        statusColor = accentGreen;
                        icon = Icons.add_circle_outline;
                      } else if (aksi == 'UPDATE') {
                        statusColor = accentOrange;
                        icon = Icons.edit_note;
                      } else {
                        statusColor = Colors.redAccent;
                        icon = Icons.delete_forever;
                      }

                      // Format tanggal
                      DateTime createdAt = DateTime.parse(log['created_at']);
                      String formattedDate = DateFormat('dd MMMM yyyy, HH:mm').format(createdAt);

                      return _buildActivityCard(
                        role: aksi,
                        date: formattedDate,
                        desc: log['deskripsi'] ?? 'Tidak ada deskripsi',
                        status: aksi,
                        statusColor: statusColor,
                        icon: icon,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard({
    required String role,
    required String date,
    required String desc,
    required String status,
    required Color statusColor,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: espresso,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: vanilla, size: 26),
                  const SizedBox(width: 12),
                  Text(
                    role,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor, width: 1.5),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(date, style: TextStyle(color: vanilla, fontSize: 13)),
          const SizedBox(height: 6),
          Text(desc, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}