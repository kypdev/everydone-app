import 'package:everydone_app/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'bottom_navy.dart';

final _kanit = 'Kanit';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  bool showPwd;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    showPwd = true;
    super.initState();
  }

  _signin() {
    debugPrint('login');
    String email = emailInputController.text.trim().toString();
    String pwd = pwdInputController.text.toString();
    debugPrint('email: ${email}');
    debugPrint('pass: ${pwd}');
    if (_loginFormKey.currentState.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: pwd,
          )
          .then((currrentUser) => Firestore.instance
              .collection("users")
              .document(currrentUser.user.uid)
              .get()
              .then((DocumentSnapshot result) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavy()))))
          .catchError((err) {
        print(err);
        Alert(
          context: context,
          type: AlertType.error,
          title: "คำเตือน",
          desc: "อีเมลล์หรือรหัสผ่านผิด",
          buttons: [
            DialogButton(
              child: Text(
                "ยืนยัน",
                style: TextStyle(
                    fontFamily: _kanit, color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
      });
    }
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
          builder: (context) => SignupScreen(),
        ));
  }

  Future _forgotPassword() async {
    print('forgotpassword');
  }

  Widget _formSignin({
    Icon icon,
    Function val,
    String label,
    TextEditingController controller,
    Widget suffixIcon,
    bool ob,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: TextFormField(
        controller: controller,
        validator: val,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            fontFamily: _kanit,
          ),
          prefixIcon: icon,
          fillColor: Colors.grey[100],
          filled: true,
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: _kanit,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: suffixIcon,
        ),
        obscureText: ob,
      ),
    );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value.length < 5) {
      return 'อีเมลล์ไม่ถูกต้อง';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
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
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Card(
                        elevation: 5,
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              _formSignin(
                                ob: false,
                                label: 'อีเมลล์',
                                controller: emailInputController,
                                icon: Icon(FontAwesomeIcons.envelope),
                                val: emailValidator,
                              ),
                              _formSignin(
                                ob: showPwd,
                                label: 'รหัสผ่าน',
                                controller: pwdInputController,
                                icon: Icon(FontAwesomeIcons.lock),
                                val: (value) {
                                  if (value.length < 6) {
                                    return 'รหัสผ่านต้องมากกว่า 5 ตัวอักษร';
                                  }
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPwd
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (showPwd == true) {
                                        showPwd = false;
                                      } else {
                                        showPwd = true;
                                      }
                                    });
                                  },
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
                                    onPressed: _signin,
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
            ),
            Center(
              child: Visibility(
                  visible: false,
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
