import 'package:flutter/material.dart';

final _kanit = 'Kanit';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        title: Text('แก้ไขโปรไฟล์',
        style: TextStyle(
          fontFamily: _kanit,

        ),
        ),
      ),
    );
  }
}