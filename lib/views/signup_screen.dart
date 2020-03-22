import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'bottom_navy.dart';

final String _kanit = 'Kanit';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  File _imageFile;
  bool load;
  int _gender_value;
  bool showPwd;


  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        // ratioX: 1.0,
        // ratioY: 1.0,
        // maxWidth: 512,
        // maxHeight: 512,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop It');

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Widget showImage(BuildContext context) {
    return Center(
      child: _imageFile == null
          ? Stack(
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 200.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 4.0, color: Colors.grey),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140, left: 150),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () => _camera(context),
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 4.0, color: Colors.grey),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: FileImage(_imageFile) == null
                          ? Center(
                              child: Text('loading....'),
                            )
                          : FileImage(_imageFile),
                      radius: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140, left: 150),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () => _camera(context),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _camera(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text(
                    'กล้อง',
                    style: TextStyle(
                      fontFamily: _kanit,
                    ),
                  ),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text(
                    'คลังรูปภาพ',
                    style: TextStyle(
                      fontFamily: _kanit,
                    ),
                  ),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    showPwd = true;
    load = false;
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'รูปแบบอีเมลล์ไม่ถูกต้อง';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'รหัสผ่านต้องมากกว่าหรือเท่ากับ 6 ตัวอักษร';
    } else {
      return null;
    }
  }

  Widget _formSignup({
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

  _register() {

    print('register');
    if (_registerFormKey.currentState.validate()) {
      String firstname = firstNameInputController.text.trim().toString();
      String lastname = lastNameInputController.text.trim().toString();
      String email = emailInputController.text.trim().toString();
      String pwd = pwdInputController.text.toString();
      String conpwd = confirmPwdInputController.text.toString();

      debugPrint('firstname: ${firstname}');
      debugPrint('lastname: ${lastname}');
      debugPrint('email: ${email}');
      debugPrint('pass: ${pwd}');
      debugPrint('conpass: ${conpwd}');

      if (pwdInputController.text ==
          confirmPwdInputController.text){
        setState(() {
          load = true;
        });
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email,
            password: pwd)
            .then((currentUser) => Firestore.instance
            .collection("users")
            .document(currentUser.user.uid)
            .setData({
          "uid": currentUser.user.uid,
          "fname": firstname,
          "surname": lastname,
          "email": email,
        })
            .then((result) => {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavy()),
                  (_) => false),
          firstNameInputController.clear(),
          lastNameInputController.clear(),
          emailInputController.clear(),
          pwdInputController.clear(),
          confirmPwdInputController.clear()
        })
            .catchError((err) {
              setState(() {
                load = false;
              });
              print(err);
//              if(signUpError is PlatformException) {
//                if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//                  /// `foo@bar.com` has alread been registered.
//                }
//              }
        }));
      }else{
        Alert(
          context: context,
          type: AlertType.error,
          title: "คำเตือน",
          desc: "กรุณากรอกรหัสผ่านให้ตรงกัน",
          buttons: [
            DialogButton(
              child: Text(
                "ยืนยัน",
                style: TextStyle(
                  fontFamily: _kanit,
                    color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สมัครสมาชิก',
          style: TextStyle(fontFamily: _kanit),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  elevation: 5,
                  child: Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            showImage(context),
                            SizedBox(height: 20),
                            _formSignup(
                                ob: false,
                                label: 'ชื่อ',
                                controller: firstNameInputController,
                                icon: Icon(FontAwesomeIcons.userCircle),
                                val: (value) {
                                  if (value.length < 5) {
                                    return 'ชื่อห้ามน้อยกว่า 5 ตัวอักษร';
                                  }
                                }),
                            _formSignup(
                                ob: false,
                                label: 'นามสกุล',
                                controller: lastNameInputController,
                                icon: Icon(FontAwesomeIcons.userCircle),
                                val: (value) {
                                  if (value.length < 5) {
                                    return 'นามสกุลห้ามน้อยกว่า 5 ตัวอักษร';
                                  }
                                }),
                            _formSignup(
                              ob: false,
                              label: 'อีเมลล์',
                              controller: emailInputController,
                              icon: Icon(FontAwesomeIcons.envelope),
                              val: emailValidator,
                            ),
                            _formSignup(
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
                            _formSignup(
                              ob: showPwd,
                              label: 'ยืนยันรหัสผ่าน',
                              controller: confirmPwdInputController,
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: RaisedButton(
                                elevation: 10,
                                color: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: _register,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Text(
                                        'สมัครสมาชิก',
                                        style: TextStyle(
                                          fontFamily: _kanit,
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Visibility(
                visible: load,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator())),
          ),
        ],
      ),
    );
  }
}
