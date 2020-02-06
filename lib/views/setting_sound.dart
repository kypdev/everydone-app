import 'package:flutter/material.dart';

final _kanit = 'Kanit';

class SettingSound extends StatefulWidget {
  @override
  _SettingSoundState createState() => _SettingSoundState();
}

class _SettingSoundState extends State<SettingSound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text('ตั้งค่าเสียง',
        style: TextStyle(
          fontFamily: _kanit,
        ),
        ),
      ),
    );
  }
}