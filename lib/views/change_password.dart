import 'package:flutter/material.dart';
import 'package:everydone_app/commons/form_change_password.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _kanit = 'Kanit';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  bool obCurrentPassword = true;
  bool obNewPassword = true;
  bool obConNewPassword = true;

  String currentPWDVal(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  changePassword() {
    print('change password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เปลี่ยนรหัสผ่าน',
          style: TextStyle(fontFamily: _kanit),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black12,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: SingleChildScrollView(
              child: Card(
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        changePasswordForm(
                          controller: currentPassword,
                          prefixIcon: Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.grey,
                          ),
                          validator: currentPWDVal,
                          labeltext: 'รหัสผ่านเก่า',
                          obscureText: obCurrentPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obCurrentPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                if (obCurrentPassword == true) {
                                  obCurrentPassword = false;
                                } else {
                                  obCurrentPassword = true;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        changePasswordForm(
                          controller: currentPassword,
                          prefixIcon: Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.grey,
                          ),
                          validator: currentPWDVal,
                          labeltext: 'รหัสผ่านใหม่',
                          obscureText: obNewPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                if (obNewPassword == true) {
                                  obNewPassword = false;
                                } else {
                                  obNewPassword = true;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        changePasswordForm(
                          controller: currentPassword,
                          prefixIcon: Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.grey,
                          ),
                          validator: currentPWDVal,
                          labeltext: 'ยืนยันรหัสผ่านใหม่',
                          obscureText: obConNewPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obConNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                if (obConNewPassword == true) {
                                  obConNewPassword = false;
                                } else {
                                  obConNewPassword = true;
                                }
                              });
                            },
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
                            onPressed: changePassword,
                            child: Text(
                              'เปลี่ยนรหัสผ่าน',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: _kanit,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
