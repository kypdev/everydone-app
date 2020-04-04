import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:everydone_app/views/history_screen.dart';
import 'package:everydone_app/views/home_screen.dart';
import 'package:everydone_app/views/reccommend_screen.dart';
import 'package:everydone_app/views/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final String _kanit = 'Kanit';

class BottomNavy extends StatefulWidget {
  @override
  _BottomNavyState createState() => _BottomNavyState();
}

class _BottomNavyState extends State<BottomNavy> {
  TextStyle style = TextStyle(fontFamily: _kanit);

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            HistoryScreen(),
            ReccommendScreen(),
            SettingScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('หน้าแรก', style: style),
            icon: Icon(FontAwesomeIcons.home),
            activeColor: Colors.blue,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            title: Text(
              'ประวัติ',
              style: style,
            ),
            icon: Icon(Icons.apps),
            activeColor: Colors.red,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            title: Text(
              'แนะนำ',
              style: style,
            ),
            icon: Icon(Icons.chat_bubble),
            activeColor: Colors.deepPurple,
            inactiveColor: Colors.grey[600],
          ),
          BottomNavyBarItem(
            title: Text(
              'ตั้งค่า',
              style: style,
            ),
            icon: Icon(Icons.settings),
            inactiveColor: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}
