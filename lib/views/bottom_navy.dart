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
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(), HistoryScreen(), ReccommendScreen(), SettingScreen()
  ];
  Widget currentScreen = HomeScreen();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageStorage(child: currentScreen, bucket: bucket),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentTab,
        onItemSelected: (i) {
          setState(() {
            currentTab = i;
            currentScreen = screens[i];
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.home),
            title: Text('หน้าแรก', style: style),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.chartBar),
            title: Text('ประวัติ', style: style),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.clipboardList),
            title: Text(
              'แนะนำ',
              style: style,
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.cog),
            title: Text('ตั้งค่า'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
