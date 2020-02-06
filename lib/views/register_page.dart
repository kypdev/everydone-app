import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _kanit = 'Kanit';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  File imageFile;

  bool obsecuretext = true;
  int _gender_value;

  _birthday() {
    debugPrint('calendar');
  }

  TextEditingController _firstnameCtrl = new TextEditingController();
  TextEditingController _lastnameCtrl = new TextEditingController();
  TextEditingController _usernameCtrl = new TextEditingController();
  TextEditingController _passwordCtrl = new TextEditingController();
  TextEditingController _conpasswordCtrl = new TextEditingController();
  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _birthCtrl = new TextEditingController();

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make a Choice!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallary'),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _selectImageProfile() {
    debugPrint('profile image');
    _openGallary(context);
  }

  _imageProfile() {
    if (imageFile == null) {
      return Container(
        height: 160,
        width: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/upload.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 100, top: 110),
            child: IconButton(
              icon: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                ),
              ),
              onPressed: () {
                _showChoiceDialog(context);
              },
            ),
          ),
        ),
      );
    } else {
      return Stack(
        children: <Widget>[
          Container(
            width: 160.0,
            height: 160.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ExactAssetImage(imageFile.path),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 100, top: 120),
              child: IconButton(
                icon: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 20,
                  ),
                ),
                onPressed: () {
                  _showChoiceDialog(context);
                },
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สมัครสมาชิก',
          style: TextStyle(
            fontFamily: _kanit,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Container(
                  child: _imageProfile(),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    formSignup(
                      formCtrl: _firstnameCtrl,
                      prefixIcon: Icon(FontAwesomeIcons.userCircle),
                      label: 'ชื่อ',
                      obsecure: false,
                    ),
                    formSignup(
                      formCtrl: _lastnameCtrl,
                      prefixIcon: Icon(FontAwesomeIcons.portrait),
                      label: 'นามสกุล',
                      obsecure: false,
                    ),
                    formSignup(
                      formCtrl: _usernameCtrl,
                      prefixIcon: Icon(FontAwesomeIcons.user),
                      label: 'ชื่อผู้ใช้',
                      obsecure: false,
                    ),
                    formSignup(
                      formCtrl: _passwordCtrl,
                      prefixIcon: Icon(FontAwesomeIcons.lock),
                      label: 'รหัสผ่าน',
                      obsecure: obsecuretext,
                      sufficIcon: IconButton(
                        icon: Icon(
                          obsecuretext ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: (){
                          setState(() {
                            if(obsecuretext == true){
                              obsecuretext = false;
                            }else{
                              obsecuretext = true;
                            }
                          });
                        },
                      ),
                    ),
                    formSignup(
                      formCtrl: _conpasswordCtrl,
                      prefixIcon: Icon(FontAwesomeIcons.lock),
                      label: 'ยืนยันรหัสผ่าน',
                      obsecure: obsecuretext,
                      sufficIcon: IconButton(
                        icon: Icon(
                          obsecuretext ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: (){
                          setState(() {
                            if(obsecuretext == true){
                              obsecuretext = false;
                            }else{
                              obsecuretext = true;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'เพศ',
                          style: TextStyle(fontFamily: _kanit),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              onChanged: (value) {
                                setState(() {
                                  _gender_value = value;
                                });
                              },
                              value: 1,
                              groupValue: _gender_value,
                            ),
                            Text(
                              'ชาย',
                              style: TextStyle(
                                fontFamily: _kanit,
                              ),
                            ),
                            Radio(
                              onChanged: (value) {
                                setState(() {
                                  _gender_value = value;
                                });
                              },
                              value: 2,
                              groupValue: _gender_value,
                            ),
                            Text(
                              'หญิง',
                              style: TextStyle(
                                fontFamily: _kanit,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        formSignup(
                          formCtrl: _birthCtrl,
                          prefixIcon: Icon(
                            FontAwesomeIcons.birthdayCake,
                          ),
                          label: 'วันเกิด',
                          obsecure: false,
                          sufficIcon: IconButton(
                            onPressed: () {
                              _birthday();
                            },
                            icon: Icon(
                              FontAwesomeIcons.calendarDay,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.greenAccent,
                            onPressed: () {
                              //_register();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'สมัครสมาชิก',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget formSignup({
  formCtrl,
  Icon prefixIcon,
  String label,
  bool obsecure,
  Widget sufficIcon,
}) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: TextFormField(
      obscureText: obsecure,
      controller: formCtrl,
      decoration: InputDecoration(
        suffixIcon: sufficIcon,
        icon: prefixIcon,
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: _kanit,
        ),
      ),
    ),
  );
}
