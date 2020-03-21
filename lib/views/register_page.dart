//import 'package:everydone_app/views/bottom_navy.dart';
//import 'package:everydone_app/views/home_screen.dart';
//import 'package:flutter/material.dart';
//import 'dart:io';
//import 'package:image_picker/image_picker.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter_picker/flutter_picker.dart';
//import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:image_cropper/image_cropper.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//
//final _kanit = 'Kanit';
//
//class RegisterPage extends StatefulWidget {
//  @override
//  _RegisterPageState createState() => _RegisterPageState();
//}
//
//class _RegisterPageState extends State<RegisterPage> {
//
//  final _formKey = GlobalKey<FormState>();
//  File _imageFile;
//  bool obsecuretext = true;
//  int _gender_value;
//
//  TextEditingController _firstnameCtrl = new TextEditingController();
//  TextEditingController _lastnameCtrl = new TextEditingController();
//  TextEditingController _usernameCtrl = new TextEditingController();
//  TextEditingController _passwordCtrl = new TextEditingController();
//  TextEditingController _conpasswordCtrl = new TextEditingController();
//  TextEditingController _emailCtrl = new TextEditingController();
//  TextEditingController _birthCtrl = new TextEditingController();
//
//  Future _register() async {
//    if (_formKey.currentState.validate()) {
//      String pwd;
//
//      if (_passwordCtrl.text == _conpasswordCtrl.text) {
//        pwd = _passwordCtrl.text.toString();
//      }else{
//        Alert(
//          context: context,
//
//          type: AlertType.warning,
//          title: "คำเตือน",
//          desc: "กรุณากรอกรหัสผ่านให้ตรงกัน",
//          buttons: [
//            DialogButton(
//              child: Text(
//                "ตกลง",
//                style: TextStyle(color: Colors.white, fontSize: 20),
//              ),
//              onPressed: () => Navigator.pop(context),
//              color: Color.fromRGBO(0, 179, 134, 1.0),
//              radius: BorderRadius.circular(0.0),
//            ),
//          ],
//        ).show();
//      }
//      print('firstname:' + _firstnameCtrl.text);
//      print('lastname:' + _lastnameCtrl.text);
//      print('username:' + _usernameCtrl.text);
//      print('email:' + _emailCtrl.text);
//      print(pwd);
//
//      FirebaseAuth.instance
//          .createUserWithEmailAndPassword(email: 'tua@test.com', password: '123456')
//          .then((currentUser) => Firestore.instance
//          .collection("users")
//          .document(currentUser.user.uid)
//          .setData({
//        "uid": currentUser.user.uid,
//        "firstname": 'Piyakit',
//        "lastname": 'lastname',
//        "email": 'tua@test.com',
//        "password": '123456',
//
//      })
//          .then((result) => {
//        Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(
//                builder: (context) => BottomNavy()),
//                (_) => false),
//        _firstnameCtrl.clear(),
//        _lastnameCtrl.clear(),
//        _emailCtrl.clear(),
//        _passwordCtrl.clear(),
//        _conpasswordCtrl.clear()
//      })
//          .catchError((err) => print(err)))
//          .catchError((err) => print(err));
//    }
//  }
//
//  Future<void> _cropImage() async {
//    File cropped = await ImageCropper.cropImage(
//        sourcePath: _imageFile.path,
//        // ratioX: 1.0,
//        // ratioY: 1.0,
//        // maxWidth: 512,
//        // maxHeight: 512,
//        toolbarColor: Colors.purple,
//        toolbarWidgetColor: Colors.white,
//        toolbarTitle: 'Crop It');
//
//    setState(() {
//      _imageFile = cropped ?? _imageFile;
//    });
//  }
//
//  /// Select an image via gallery or camera
//  Future<void> _pickImage(ImageSource source) async {
//    File selected = await ImagePicker.pickImage(source: source);
//
//    setState(() {
//      _imageFile = selected;
//    });
//  }
//
//  Widget showImage(BuildContext context) {
//    return Center(
//      child: _imageFile == null
//          ? Stack(
//              children: <Widget>[
//                Container(
//                  height: 200,
//                  width: 200,
//                  alignment: Alignment.center,
//                  decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    border: Border.all(width: 1.0, color: Colors.grey),
//                    image: DecorationImage(
//                      fit: BoxFit.cover,
//                      image: NetworkImage(
//                          'https://firebasestorage.googleapis.com/v0/b/login-ce9de.appspot.com/o/user%2Fimages.png?alt=media&token=bbc9397d-f425-4834-82f1-5e6855b4a171'),
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 140, left: 150),
//                  child: Container(
//                    width: 50,
//                    height: 50,
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      border: Border.all(color: Colors.black26),
//                      color: Colors.white,
//                    ),
//                    child: IconButton(
//                      icon: Icon(Icons.camera_alt),
//                      onPressed: ()  =>_camera(context),
//                    ),
//                  ),
//                ),
//              ],
//            )
//          : Stack(
//            children: <Widget>[
//              Container(
//                width: 200,
//                height: 200,
//                child: CircleAvatar(
//                    backgroundColor: Colors.transparent,
//                    backgroundImage: FileImage(_imageFile) == null
//                        ? Center(
//                            child: Text('loading....'),
//                          )
//                        : FileImage(_imageFile),
//                    radius: 120,
//                  ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(top: 140, left: 150),
//                child: Container(
//                  width: 50,
//                  height: 50,
//                  decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    border: Border.all(color: Colors.black26),
//                    color: Colors.white,
//                  ),
//                  child: IconButton(
//                    icon: Icon(Icons.camera_alt),
//                    onPressed: ()  =>_camera(context),
//                  ),
//                ),
//              ),
//            ],
//          ),
//    );
//  }
//
//  void _camera(context){
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext bc){
//          return Container(
//            child: new Wrap(
//              children: <Widget>[
//                new ListTile(
//                    leading: new Icon(Icons.camera_alt),
//                    title: new Text('กล้อง',
//                    style: TextStyle(
//                      fontFamily: _kanit,
//                    ),
//                    ),
//                    onTap: () {
//                      _pickImage(ImageSource.camera);
//                      Navigator.pop(context);
//                    },
//                ),
//                new ListTile(
//                  leading: new Icon(Icons.photo_library),
//                  title: new Text('คลังรูปภาพ',
//                    style: TextStyle(
//                      fontFamily: _kanit,
//                    ),
//                  ),
//                  onTap: (){
//                    _pickImage(ImageSource.gallery);
//                    Navigator.pop(context);
//                  },
//                ),
//              ],
//            ),
//          );
//        }
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          'สมัครสมาชิก',
//          style: TextStyle(
//            fontFamily: _kanit,
//          ),
//        ),
//        centerTitle: true,
//        backgroundColor: Colors.greenAccent,
//      ),
//      body: SafeArea(
//        child: Center(
//          child: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                SizedBox(height: 20),
//                Container(
//                  child: Container(
//                    child: showImage(context),
//                  ),
//                ),
//                SizedBox(height: 20),
//                Form(
//                  key: _formKey,
//                  child: Column(
//                    children: <Widget>[
//                      formSignup(
//                        val:
//                        formCtrl: _firstnameCtrl,
//                        prefixIcon: Icon(FontAwesomeIcons.userCircle),
//                        label: 'ชื่อ',
//                        obsecure: false,
//                      ),
//                      formSignup(
//                        formCtrl: _lastnameCtrl,
//                        prefixIcon: Icon(FontAwesomeIcons.portrait),
//                        label: 'นามสกุล',
//                        obsecure: false,
//                      ),
//                      formSignup(
//                        formCtrl: _usernameCtrl,
//                        prefixIcon: Icon(FontAwesomeIcons.user),
//                        label: 'อีเมลล์',
//                        obsecure: false,
//                      ),
//                      formSignup(
//                        formCtrl: _passwordCtrl,
//                        prefixIcon: Icon(FontAwesomeIcons.lock),
//                        label: 'รหัสผ่าน',
//                        obsecure: obsecuretext,
//                        sufficIcon: IconButton(
//                          icon: Icon(
//                            obsecuretext
//                                ? Icons.visibility_off
//                                : Icons.visibility,
//                          ),
//                          onPressed: () {
//                            setState(() {
//                              if (obsecuretext == true) {
//                                obsecuretext = false;
//                              } else {
//                                obsecuretext = true;
//                              }
//                            });
//                          },
//                        ),
//                      ),
//                      formSignup(
//                        formCtrl: _conpasswordCtrl,
//                        prefixIcon: Icon(FontAwesomeIcons.lock),
//                        label: 'ยืนยันรหัสผ่าน',
//                        obsecure: obsecuretext,
//                        sufficIcon: IconButton(
//                          icon: Icon(
//                            obsecuretext
//                                ? Icons.visibility_off
//                                : Icons.visibility,
//                          ),
//                          onPressed: () {
//                            setState(() {
//                              if (obsecuretext == true) {
//                                obsecuretext = false;
//                              } else {
//                                obsecuretext = true;
//                              }
//                            });
//                          },
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Column(
//                        children: <Widget>[
//                          Text(
//                            'เพศ',
//                            style: TextStyle(fontFamily: _kanit),
//                          ),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              Radio(
//                                onChanged: (value) {
//                                  setState(() {
//                                    _gender_value = value;
//                                  });
//                                },
//                                value: 1,
//                                groupValue: _gender_value,
//                              ),
//                              Text(
//                                'ชาย',
//                                style: TextStyle(
//                                  fontFamily: _kanit,
//                                ),
//                              ),
//                              Radio(
//                                onChanged: (value) {
//                                  setState(() {
//                                    _gender_value = value;
//                                  });
//                                },
//                                value: 2,
//                                groupValue: _gender_value,
//                              ),
//                              Text(
//                                'หญิง',
//                                style: TextStyle(
//                                  fontFamily: _kanit,
//                                ),
//                              ),
//                            ],
//                          ),
//                          SizedBox(height: 20),
//                          Padding(
//                            padding: const EdgeInsets.only(left: 20, right: 20),
//                            child: BasicDateTimeField(),
//                          ),
//                          SizedBox(height: 20),
//                          Padding(
//                            padding: const EdgeInsets.only(left: 20, right: 20),
//                            child: RaisedButton(
//                              shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(20),
//                              ),
//                              color: Colors.greenAccent,
//                              onPressed: () {
//                                _register();
//                              },
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  Text(
//                                    'สมัครสมาชิก',
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(color: Colors.white),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                      SizedBox(height: 20),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//Widget formSignup({
//  formCtrl,
//  Icon prefixIcon,
//  String label,
//  bool obsecure,
//  Widget sufficIcon,
//  Function val,
//}) {
//  return Container(
//    padding: EdgeInsets.only(left: 20, right: 20),
//    child: TextFormField(
//      validator: val,
//      obscureText: obsecure,
//      controller: formCtrl,
//      decoration: InputDecoration(
//        suffixIcon: sufficIcon,
//        icon: prefixIcon,
//        labelText: label,
//        labelStyle: TextStyle(
//          fontFamily: _kanit,
//        ),
//      ),
//    ),
//  );
//}
//
//class BasicDateTimeField extends StatelessWidget {
//  final format = DateFormat("yyyy-MM-dd");
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(children: <Widget>[
////      Text('Basic date & time field (${format.pattern})'),
//      DateTimeField(
//        decoration: InputDecoration(
//          icon: Icon(Icons.calendar_today),
//        ),
//        format: format,
//        onShowPicker: (context, currentValue) async {
//          final date = await showDatePicker(
//              context: context,
//              firstDate: DateTime(1900),
//              initialDate: currentValue ?? DateTime.now(),
//              lastDate: DateTime(2100));
//          if (date != null) {
//            final time = await showTimePicker(
//              context: context,
//              initialTime:
//                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//            );
//            return DateTimeField.combine(date, time);
//          } else {
//            return currentValue;
//          }
//        },
//      ),
//    ]);
//  }
//}
