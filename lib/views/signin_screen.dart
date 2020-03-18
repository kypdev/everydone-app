import 'package:everydone_app/views/bottom_nav.dart';
import 'package:everydone_app/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'first_pressure.dart';

final _kanit = 'Kanit';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool visible = false;
  TextEditingController _usernameCtrl = new TextEditingController();

  TextEditingController _passwordCtrl = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future _userSignin() async {
    print('login');
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: _usernameCtrl.text,
        password: _passwordCtrl.text)
        .then((currentUser) => Firestore.instance
        .collection("users")
        .document(currentUser.user.uid)
        .get()
        .then((DocumentSnapshot result) =>
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNav(
                ))))
        .catchError((err) => print(err)))
        .catchError((err) => print(err));
  }

  Future _facebookSignin() async {
    print('facebook signin');
  }

  Future _googleSignin() async {
    print('google signin');
  }

  Future _register() async {
    print('register');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ));
  }

  Future _forgotPassword() async {
    print('forgotpassword');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            bg(
              h: MediaQuery.of(context).size.height,
              half: MediaQuery.of(context).size.height / 1.8,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 5,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'ชื่อผู้ใช้ห้ามว่าง';
                                  } else if (value.length < 6) {
                                    return 'ชื่อผู้ใช้ห้ามน้อยกว่า 6 ตัวอักษร';
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(
                                  fontFamily: _kanit,
                                ),
                                controller: _usernameCtrl,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  labelText: 'ชื่อผู้ใช้',
                                  labelStyle: TextStyle(
                                    fontFamily: _kanit,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'รหัสผ่านห้ามว่าง';
                                  } else if (value.length < 8) {
                                    return 'รหัสผ่านห้ามน้อยกว่า 8 ตัวอักษร';
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: true,
                                style: TextStyle(
                                  fontFamily: _kanit,
                                ),
                                controller: _passwordCtrl,
                                decoration: InputDecoration(
                                  
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: 'รหัสผ่าน',
                                  labelStyle: TextStyle(
                                    fontFamily: _kanit,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: double.infinity,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    'login',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    _userSignin();
                                  },
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(0, 255, 0, 20),
                                      Color.fromRGBO(220, 200, 0, 10)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _register();
                                    },
                                    child: Text(
                                      'สมัครสมาชิก',
                                      style: TextStyle(fontFamily: _kanit),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _forgotPassword();
                                    },
                                    child: Text(
                                      'ลืมรหัสผ่าน?',
                                      style: TextStyle(fontFamily: _kanit),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: 20),
                                Expanded(
                                  child: Divider(
                                    color: Colors.black54,
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'หรือเข้าสู่ระบบด้วย',
                                  style: TextStyle(
                                    fontFamily: _kanit,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Divider(
                                    color: Colors.black54,
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  _facebookSignin();
                                },
                                color: Color(0xff3b5998),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.facebook,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'เข้าสู่ระบบด้วย Facebook',
                                      style: TextStyle(
                                          fontFamily: _kanit,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  _googleSignin();
                                },
                                color: Color(0xffDB4437),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.google,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      'เข้าสู่ระบบด้วย Google',
                                      style: TextStyle(
                                          fontFamily: _kanit,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Visibility(
                  visible: visible,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
    );
  }
}

Widget bg({h, half}) {
  return Stack(
    children: <Widget>[
      Container(
        height: h,
        color: Color(0xff82E0AA),
      ),
    ],
  );
}
