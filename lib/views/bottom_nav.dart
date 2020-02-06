import 'package:everydone_app/views/reccommend_screen.dart';
import 'package:flutter/material.dart';

import 'history_screen.dart';
import 'home_screen.dart';
import 'setting_screen.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedItem = 0;
  final _pageOption = [
    HomeScreen(),
    HistoryScreen(),
    ReccommendScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedItem,
        onTap: (int index) {
          setState(() {
            _selectedItem = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('หน้าหลัก'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('ประวัติ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('แนะนำ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('ตั้งค่า'),
          ),
        ],
      ),
    );
  }
}
