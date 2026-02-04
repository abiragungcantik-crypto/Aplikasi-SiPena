import 'package:flutter/material.dart';

class PetugasNavbar extends StatelessWidget {
  final int currentIndex;
  const PetugasNavbar({super.key, required this.currentIndex});

  final Color espresso = const Color(0xFF5D3216);
  final Color vanilla = const Color(0xFFD9C5B2);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: espresso,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: vanilla.withOpacity(0.6),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == currentIndex) return;
          
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard_petugas');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/alat_petugas');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/persetujuan_petugas');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Alat'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: 'Persetujuan'),
        ],
      ),
    );
  }
}