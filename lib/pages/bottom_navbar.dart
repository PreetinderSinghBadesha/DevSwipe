import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jobify/pages/home_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.95;
    return Scaffold(
      body: pages[_selectedIndex],
      backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        color: const Color.fromRGBO(111, 39, 152, 1),
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            size: (_selectedIndex == 0) ? width / 12 : width / 15,
            color: Colors.white,
          ),
          Icon(
            Icons.location_on,
            size: (_selectedIndex == 1) ? width / 12 : width / 15,
            color: Colors.white,
          ),
          Icon(
            Icons.qr_code_sharp,
            size: (_selectedIndex == 2) ? width / 12 : width / 15,
            color: Colors.white,
          ),
          // Icon(
          //   Icons.event,
          //   size: (_selectedIndex == 3) ? width / 12 : width / 15,
          //   color: Colors.white,
          // ),
          Icon(
            Icons.notifications,
            size: (_selectedIndex == 4) ? width / 12 : width / 15,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
