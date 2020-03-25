import 'package:everydone_app/views/alarm_screen.dart';
import 'package:everydone_app/views/edit_profile.dart';
import 'package:everydone_app/views/setting_sound.dart';
import 'package:everydone_app/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _kanit = 'Kanit';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  _editProfile() {
    Navigator.of(context).push(_createRoute(screen: EditProfile()));
  }

  _alarm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AlarmScreen()));
  }

  _settingSound() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingSound()));
  }

  _share() {
    debugPrint('share');
  }

  _changePassword() {
    debugPrint('change password');
  }

  _signout() {
    FirebaseAuth.instance
        .signOut()
        .then((result) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SigninScreen())))
        .catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.black12,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Card(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _editProfile();
                          },
                          child: listMenu(
                            w: MediaQuery.of(context).size.width,
                            icon: Icon(
                              FontAwesomeIcons.userCircle,
                              color: Colors.black54,
                            ),
                            menuName: 'แก้ไขโปรไฟล์',
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _editProfile();
                          },
                          child: listMenu(
                            w: MediaQuery.of(context).size.width,
                            icon: Icon(
                              FontAwesomeIcons.userCircle,
                              color: Colors.black54,
                            ),
                            menuName: 'เปลี่ยนรหัสผ่าน',
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _alarm();
                          },
                          child: listMenu(
                            w: MediaQuery.of(context).size.width,
                            icon: Icon(
                              Icons.alarm,
                              color: Colors.black54,
                            ),
                            menuName: 'เตือน',
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            _settingSound();
                          },
                          child: listMenu(
                            w: MediaQuery.of(context).size.width,
                            icon: Icon(
                              Icons.volume_up,
                              color: Colors.black54,
                            ),
                            menuName: 'ตั้งค่าเสียง',
                          ),
                        ),

                         GestureDetector(
                           onTap: () {
                             _share();
                           },
                           child: listMenu(
                             w: MediaQuery.of(context).size.width,
                             icon: Icon(
                               Icons.share,
                               color: Colors.black54,
                             ),
                             menuName: 'แชร์',
                           ),
                         ),

                        GestureDetector(
                          onTap: () {
                            _signout();
                          },
                          child: listMenu(
                            w: MediaQuery.of(context).size.width,
                            icon: Icon(
                              Icons.power_settings_new,
                              color: Colors.black54,
                            ),
                            menuName: 'ออกจากระบบ',
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget listMenu({
  w,
  Icon icon,
  String menuName,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: Container(
      child: Column(
        children: <Widget>[
          Container(
            width: w,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  icon,
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    menuName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: _kanit,
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Route _createRoute({screen}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
