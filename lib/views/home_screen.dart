import 'package:everydone_app/views/choose_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_switch/custom_switch.dart';

final _kanit = 'Kanit';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool status = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              ? manual()
                              : camera(
                                  w: MediaQuery.of(context).size.width,
                                  deviceName: _deviceName,
                                  h: MediaQuery.of(context).size.height,
                                  pressureImage: 'assets/images/device.jpg',
                                  selectFunction: _selectPressureDevice,
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
        ],
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

Widget manual() {
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
                Container(
                  color: Colors.greenAccent,
                  height: 10.0,
                ),
                Container(
                  color: Colors.yellow,
                  height: 10.0,
                ),
                Container(
                  color: Colors.pink,
                  height: 10.0,
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
