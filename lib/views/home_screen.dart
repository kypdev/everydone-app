import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../commons/res_alert.dart';

final _kanit = 'Kanit';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;
  int _sysValue = 50;
  int _diaValue = 50;
  int _pulseValue = 50;
  int _sysImgValue = 126;
  int _diaImgValue = 96;
  String userID = '';
  String color;
  String rate = 'default';
  Future<File> file;
  String statuss = '';
  String base64Image;
  File tmpFile;
  bool loading = false;

  ResAlert resAlert = ResAlert();

  Future _savePressure() async {
    debugPrint('save');
    int sys = int.parse(_sysValue.toString());
    int dia = int.parse(_diaValue.toString());
    int pulse = int.parse(_pulseValue.toString());

    debugPrint('sys: ${_sysValue.toString()}');
    debugPrint('dia: ${_diaValue.toString()}');
    debugPrint('pulse: ${_pulseValue.toString()}');

    if (sys > 160 && dia > 100) {
      setState(() {
        rate = 'สูงระดับ 2';
        color = 'Colors.red';
      });
    } else if ((sys >= 141 && sys <= 160) && (dia >= 91 && dia <= 100)) {
      setState(() {
        rate = 'สูงระดับ 1';
        color = 'Colors.amber';
      });
    } else if ((sys >= 121 && sys <= 140) && (dia >= 81 && dia <= 90)) {
      setState(() {
        rate = 'สูงกว่าปกติ';
        color = 'Colors.yellow';
      });
    } else if ((sys >= 91 && sys <= 120) && (dia >= 61 && dia <= 80)) {
      setState(() {
        rate = 'ปกติ';
        color = 'Colors.greenAccent';
      });
    } else if (sys < 90 && dia < 60) {
      setState(() {
        rate = 'ต่ำ';
        color = 'Colors.purple';
      });
    } else {
      setState(() {
        rate = 'ไม่สามารถคำนวณได้';
      });
    }

    print(rate);

    Alert(
      context: context,
      type: AlertType.success,
      title: "ผลการคำนวณ",
      desc: rate,
      buttons: [
        DialogButton(
          child: Text(
            "ยืนยัน",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();

    // get uid
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid;
    });

    if (rate == 'ไม่สามารถคำนวณได้') {
      Alert(
        context: context,
        type: AlertType.success,
        title: "ผลการคำนวณ",
        desc: rate,
        buttons: [
          DialogButton(
            child: Text(
              "ยืนยัน",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else {
      // add pressure to firebase
      Firestore.instance
          .collection("users")
          .document(userID)
          .collection('pressure')
          .add({
            "sys": sys,
            "dia": dia,
            "pulse": pulse,
            "create_at": DateTime.now().day.toString() +
                '/' +
                DateTime.now().month.toString() +
                '/' +
                DateTime.now().year.toString() +
                ', ' +
                DateTime.now().hour.toString() +
                ':' +
                DateTime.now().minute.toString(),
            "update_at": FieldValue.serverTimestamp(),
            "rate": rate,
            "color": color
          })
          .then((result) => {print('add success')})
          .catchError((err) {
            print(err);
            Alert(
              context: context,
              type: AlertType.success,
              title: "ผลการคำนวณ",
              desc: rate,
              buttons: [
                DialogButton(
                  child: Text(
                    "ยืนยัน",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
            ).show();
          });
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: FileImage(
                    snapshot.data,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/no-image.png'),
                fit: BoxFit.contain,
              ),
            ),
          );
        }
      },
    );
  }

  chooseImage() {
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
                    setState(() {
                      file = ImagePicker.pickImage(source: ImageSource.camera);
                    });
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
                    setState(() {
                      file = ImagePicker.pickImage(source: ImageSource.gallery);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  startUpload() {
    setState(()=>loading = true);
    if (tmpFile == null) {
      print('tmpfile null');
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
    setState(()=>loading = false);
  }

  upload(String fileName) {
    var uploadEndPoint = 'http://192.168.130.8/upload-images/upload.php';
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      if (result.statusCode == 200) {
        setState(()=>loading = false);
        resAlert.resAlert(
          context: context,
          alertType: AlertType.success,
          title: 'บันทึกรูปสำเร็จ',
          desc: '',
          btnColor: Color(0xff00bbf9),
        );
      } else {
        setState(()=>loading = false);
        resAlert.resAlert(
          context: context,
          alertType: AlertType.error,
          title: 'บันทึกรูปไม่สำเร็จ',
          desc: '',
          btnColor: Color(0xffef233c),
        );
      }
    }).catchError((error) {
      setState(()=>loading = false);
      print('Err: $error');
      resAlert.resAlert(
        context: context,
        alertType: AlertType.error,
        title: 'บันทึกรูปไม่สำเร็จ',
        desc: '',
        btnColor: Color(0xffef233c),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: <Widget>[
                                  Switch(
                                    activeColor: Colors.greenAccent,
                                    onChanged: (value) {
                                      setState(() {
                                        status = value;
                                      });
                                    },
                                    value: status,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'ใส่ด้วยตนเอง',
                                    style: TextStyle(
                                      fontFamily: _kanit,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: status
                                  ? Center(
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Table(
                                                  columnWidths: {
                                                    0: FlexColumnWidth(2.0),
                                                    1: FlexColumnWidth(6.0),
                                                    2: FlexColumnWidth(8.0),
                                                    3: FlexColumnWidth(6.0),
                                                  },
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        Container(),
                                                        Container(
                                                          child: Text(
                                                            'Systolic',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  _kanit,
                                                              fontSize: 22.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Diastolic',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  _kanit,
                                                              fontSize: 22.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Pulse',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  _kanit,
                                                              fontSize: 22.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Table(
                                              columnWidths: {
                                                0: FlexColumnWidth(5.0),
                                                1: FlexColumnWidth(5.0),
                                                2: FlexColumnWidth(5.0),
                                              },
                                              children: [
                                                TableRow(
                                                  children: [
                                                    NumberPicker.integer(
                                                      highlightSelectedValue:
                                                          true,
                                                      initialValue: _sysValue,
                                                      minValue: 20,
                                                      maxValue: 200,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _sysValue = value;
                                                        });
                                                      },
                                                    ),
                                                    NumberPicker.integer(
                                                      initialValue: _diaValue,
                                                      minValue: 20,
                                                      maxValue: 200,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _diaValue = value;
                                                        });
                                                      },
                                                    ),
                                                    NumberPicker.integer(
                                                      initialValue: _pulseValue,
                                                      minValue: 20,
                                                      maxValue: 200,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _pulseValue = value;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: MaterialButton(
                                                  onPressed: _savePressure,
                                                  child: Text(
                                                    'บันทึก',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0,
                                                      fontFamily: _kanit,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          // InkWell(
                                          //   onTap: () {
                                          //     // todo choose image
                                          //     chooseImage();
                                          //   },
                                          //   child: Container(
                                          //     height: MediaQuery.of(context)
                                          //             .size
                                          //             .height /
                                          //         4,
                                          //     width: MediaQuery.of(context)
                                          //             .size
                                          //             .width /
                                          //         1.5,
                                          //     decoration: BoxDecoration(
                                          //       color: Colors.amber,
                                          //       borderRadius:
                                          //           BorderRadius.circular(30),
                                          //       image:
                                          //       file == null ?
                                          //       DecorationImage(
                                          //         image: AssetImage(
                                          //           'assets/images/device.jpg',
                                          //         ),
                                          //         fit: BoxFit.cover,
                                          //       ) :
                                          //       showImage(),
                                          //     ),
                                          //   ),
                                          // ),

                                          showImage(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    color: Color(0xff00b4d8),
                                                    onPressed: () {
                                                      print('choose image');
                                                      chooseImage();
                                                    },
                                                    child: Text(
                                                      'เลือกรูปภาพ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: _kanit,
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Expanded(
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    color: Color(0xffffd6a5),
                                                    onPressed: () {
                                                      print(
                                                          'send image to server');
                                                      startUpload();
                                                    },
                                                    child: Text(
                                                      'บันทึก',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: _kanit,
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              color: Color(0xfffee440),
                                              onPressed: () {},
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  'คำนวณ',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: _kanit,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Table(
                                            columnWidths: {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(3),
                                              2: FlexColumnWidth(2),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Text(
                                                    'SYS:',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontFamily: _kanit,
                                                        fontSize: 40),
                                                  ),
                                                  Text(
                                                    _sysImgValue.toString(),
                                                    style: TextStyle(
                                                        fontFamily: _kanit,
                                                        fontSize: 40),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Table(
                                            columnWidths: {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(3),
                                              2: FlexColumnWidth(2),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Text(
                                                    'DIA:',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontFamily: _kanit,
                                                        fontSize: 40),
                                                  ),
                                                  Text(
                                                    _diaImgValue.toString(),
                                                    style: TextStyle(
                                                        fontFamily: _kanit,
                                                        fontSize: 40),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              color: Colors.greenAccent,
                                              onPressed: () {},
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  'บันทึก',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: _kanit,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            detailPressure(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Visibility(
                  visible: loading,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget manual({
  Function sys,
}) {
  return Container(
    child: Column(
      children: <Widget>[
        Table(
          columnWidths: {
            0: FlexColumnWidth(5.0),
            1: FlexColumnWidth(5.0),
            2: FlexColumnWidth(5.0),
          },
          children: [
            TableRow(
              children: [
                NumberPicker.integer(
                  highlightSelectedValue: true,
                  initialValue: 50,
                  minValue: 20,
                  maxValue: 200,
                  onChanged: sys,
                ),
                NumberPicker.integer(
                  initialValue: 50,
                  minValue: 20,
                  maxValue: 200,
                  onChanged: sys,
                ),
                NumberPicker.integer(
                  initialValue: 50,
                  minValue: 20,
                  maxValue: 200,
                  onChanged: sys,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget camera({
  w,
  deviceName,
  h,
  pressureImage,
  Function selectFunction,
}) {
  return Container(
    width: w,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: RaisedButton(
            color: Colors.greenAccent,
            onPressed: () {
              selectFunction();
            },
            child: Text(
              'เลือกเครื่องวัดความดัน',
              style: TextStyle(
                color: Colors.white,
                fontFamily: _kanit,
                fontSize: 18,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ชื่อเครื่อง : ',
              style: TextStyle(
                fontFamily: _kanit,
                fontSize: 18,
              ),
            ),
            Text(
              deviceName,
              style: TextStyle(
                fontFamily: _kanit,
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: h / 4,
          width: w / 1.5,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: AssetImage(
                pressureImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: MaterialButton(
            color: Colors.greenAccent,
            onPressed: () {},
            child: Container(
              width: w,
              child: Text(
                'บันทึก',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: _kanit,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget detailPressure({w}) {
  return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              titleDetailPressure(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget titleDetailPressure() {
  return Column(
    children: <Widget>[
      Divider(
        color: Colors.black54,
      ),
      Table(
        columnWidths: {
          0: FlexColumnWidth(9),
          1: FlexColumnWidth(5.0),
          2: FlexColumnWidth(5.0),
        },
        children: [
          TableRow(
            children: [
              Container(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'ระดับ',
                  style: TextStyle(
                    fontFamily: _kanit,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'SYS',
                  style: TextStyle(
                    fontFamily: _kanit,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  'DIA',
                  style: TextStyle(
                    fontFamily: _kanit,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ],
      ),
      Divider(
        color: Colors.black54,
      ),
      rowPressure(
        color: Colors.redAccent,
        detailLevel: 'สูงระดับ 2',
        sys: '> 160',
        dia: '> 100',
      ),
      rowPressure(
        color: Colors.orangeAccent,
        detailLevel: 'สูงระดับ 1',
        sys: '141 - 160',
        dia: '91 - 100',
      ),
      rowPressure(
        color: Colors.yellow,
        detailLevel: 'สูงกว่าปกติ',
        sys: '121 - 140',
        dia: '81 - 90',
      ),
      rowPressure(
        color: Colors.greenAccent,
        detailLevel: 'ปกติ',
        sys: '91 - 120',
        dia: '61 - 80',
      ),
      rowPressure(
        color: Colors.purple,
        detailLevel: 'ต่ำ',
        sys: '< 90',
        dia: '< 60',
      ),
    ],
  );
}

Widget rowPressure({
  Color color,
  String detailLevel,
  String sys,
  String dia,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Table(
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3.3),
        2: FlexColumnWidth(3.5),
        3: FlexColumnWidth(3.5),
      },
      children: [
        TableRow(
          children: [
            Container(
              height: 20,
              width: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(5),
                  topRight: const Radius.circular(5),
                  bottomLeft: const Radius.circular(5),
                  bottomRight: const Radius.circular(5),
                ),
              ),
            ),
            Text(
              detailLevel,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: _kanit,
                color: Colors.black54,
              ),
            ),
            Text(
              sys,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: _kanit,
                color: Colors.black54,
              ),
            ),
            Text(
              dia,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: _kanit,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ],
    ),
  );
}
