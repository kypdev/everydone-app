import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _kanit = 'Kanit';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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

  resetPassword() {
    if(_formkey.currentState.validate()){
      String emails = email.text.trim().toString();
      print(emails);
      _auth.sendPasswordResetEmail(email: emails);
      
    }
    print('success');
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ลืมรหัสผ่าน',
          style: TextStyle(
            fontFamily: _kanit,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                semanticContainer: true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'กรุณากรอกอีเมลเพื่อรีเซ็ตรหัสผ่าน',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: _kanit,
                            fontSize: 20.0,
                            color: Colors.black54),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formkey,
                        child: TextFormField(
                          controller: email,
                          validator: emailValidator,
                          cursorColor: Colors.greenAccent,
                          style: TextStyle(color: Colors.greenAccent[700]),
                          decoration: InputDecoration(
                            hoverColor: Colors.greenAccent,
                            labelText: 'อีเมล',
                            errorStyle: TextStyle(
                              fontFamily: _kanit,
                            ),
                            labelStyle: TextStyle(
                                fontFamily: _kanit, color: Colors.greenAccent),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.grey,
                            ),
                            fillColor: Color.alphaBlend(
                              Colors.greenAccent.withOpacity(.09),
                              Colors.grey.withOpacity(.04),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.greenAccent, width: 1.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                                        // Color.fromRGBO(0, 255, 0, 20),
                                        // Color.fromRGBO(220, 200, 0, 10)
                                        Colors.greenAccent,
                                        Colors.greenAccent[700]
                                      ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: MaterialButton(
                          onPressed: resetPassword,
                          child: Text(
                            'ส่ง',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: _kanit,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
