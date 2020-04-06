import 'package:everydone_app/services/update_image_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

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
  bool showPwd;
  FirebaseAuth _auth =  FirebaseAuth.instance;
  UpdateImageProfile updateImageProfile = UpdateImageProfile();



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

  
  Future uploadImage(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('CustomerProfile/${fileName.toString()}');
    StorageUploadTask task = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot snapshotTask = await task.onComplete;
    String downloadUrl = await snapshotTask.ref.getDownloadURL();
    if (downloadUrl != null) {
      updateImageProfile.updatePro(downloadUrl.toString(), context).then((val) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavy()),
            ModalRoute.withName('/'));
      }).catchError((e) {
        print('upload error ' +e);
      });
    }
  }

  signup(BuildContext context){
    _auth.createUserWithEmailAndPassword(
        email: emailInputController.text.trim(),
        password: pwdInputController.text.trim())
        .then((currentUser) =>
        Firestore.instance.collection('users')
            .document(currentUser.user.uid)
            .setData({
          'FirstName': firstNameInputController.text.trim(),
          'LastName': lastNameInputController.text.trim(),
          'email': emailInputController.text.trim(),
          'uid': currentUser.user.uid,
          'role': 'user'
        }).then((user) {
          print('user ok ' +currentUser.user.uid);
          uploadImage(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context)=>BottomNavy()),
              ModalRoute.withName('/'));
        }).catchError((e) {
          print('profile $e');
        })
    );
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
                                  return null;
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
                                  return null;
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
                                return null;
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
                                return null;
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
                                onPressed: (){
                                  if(_registerFormKey.currentState.validate()){
                                          signup(context);
                                  }
                                },
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
