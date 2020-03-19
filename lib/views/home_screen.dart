import 'package:everydone_app/views/choose_device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:numberpicker/numberpicker.dart';

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

  _onchangeSwitch() {
    setState(() {
      status = false;
    });
  }

  String _deviceName = 'yuwell YE670A';

  Future _selectPressureDevice() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseDevice(),
      ),
    );
  }

  Future _savePressure() {
    debugPrint('save');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('pressure value'),
            content: Column(
              children: <Widget>[
                Text('SYS : ' + _sysValue.toString()),
                Text('DIA : ' + _diaValue.toString()),
                Text('PULSE : ' + _pulseValue.toString()),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black12,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
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
                                                ),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    _savePressure();
                                                  },
                                                  child: Text(
                                                    'บันทึก',
                                                    style: TextStyle(
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: RaisedButton(
                                              color: Colors.greenAccent,
                                              onPressed: _selectPressureDevice,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'ชื่อเครื่อง : ',
                                                style: TextStyle(
                                                  fontFamily: _kanit,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                _deviceName,
                                                style: TextStyle(
                                                  fontFamily: _kanit,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/images/device.jpg',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 40, right: 40),
                                            child: MaterialButton(
                                              color: Colors.greenAccent,
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
                                                    ' ${_sysImgValue}',
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
                                                    ' ${_diaImgValue}',
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
                                                left: 40, right: 40),
                                            child: MaterialButton(
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
                            SizedBox(height: 20),
                            detailPressure(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget switchBar({
  onchange,
  value,
  Color color,
}) {
  return Container(
    child: Switch(
      onChanged: onchange,
      value: value,
    ),
  );
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

Widget detail() {
  return Row(
    children: <Widget>[
      FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.3,
        child: Container(
          color: Colors.green,
        ),
      ),
    ],
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
        dia: '100 - 109',
      ),
      rowPressure(
        color: Colors.orangeAccent,
        detailLevel: 'สูงระดับ 1',
        sys: '140 - 159',
        dia: '90 - 99',
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
        sys: 'ต่ำ',
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
