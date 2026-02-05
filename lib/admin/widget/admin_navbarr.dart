import 'package:flutter/material.dart';
import 'package:sipena/admin/dashboard/dashboard_admin_page.dart';
import 'package:sipena/admin/alat/tambah_alat_page.dart'; 
import '../kategori/kategori_alat_page.dart';
import 'package:sipena/admin/aktiviitas/aktivitas_page.dart';
import 'package:sipena/admin/user/admin_management_user.dart'; // ✅ TAMBAHKAN INI

class AdminNavbar extends StatelessWidget {
  final int currentIndex;
  const AdminNavbar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget page;
    switch (index) {
      case 0:
        page = const DashboardAdminPage();
        break;
      case 1:
        page = const AlatPage(); 
        break;
      case 2:
        // ✅ SEKARANG KE HALAMAN USER
        page = const ManagementUserPage(); 
        break;
      case 3:
        page = const KategoriPage(); 
        break;
      case 4:
        page = const LogAktivitasPage(); 
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color espresso = Color(0xFF5D3216);
    const Color vanilla = Color(0xFFD9C5B2);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) => _onTap(context, i),
      type: BottomNavigationBarType.fixed,
      backgroundColor: espresso,
      selectedItemColor: Colors.white,
      unselectedItemColor: vanilla.withOpacity(0.6),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.laptop_chromebook), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Kategori'),
        BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'Aktivitas'),
      ],
    );
  }
}
