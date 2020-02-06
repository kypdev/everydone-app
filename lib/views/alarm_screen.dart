import 'package:flutter/material.dart';

final _kanit = 'Kanit';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text('แจ้งเตือน',
        style: TextStyle(
          fontFamily: _kanit,
        ),
        ),
      ),
    );
  }
}