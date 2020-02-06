import 'package:flutter/material.dart';

final _kanit = 'Kanit';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ประวัติการบันทึก'),
      //   centerTitle: true,
      //   backgroundColor: Colors.greenAccent,
      //   leading: Container(),
      // ),
      body: Container(
        color: Colors.black12,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Card(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      historyPressure(
                        sys: '120',
                        dia: '80',
                        status: 'ปกติ',
                        date: '20/09/2019',
                        time: '11:30',
                        avg: '80',
                        colorStatus: Colors.lightGreenAccent,
                      ),
                      historyPressure(
                        sys: '139',
                        dia: '77',
                        status: 'สูงกว่าปกติ',
                        date: '21/09/2019',
                        time: '08:30',
                        avg: '66',
                        colorStatus: Colors.yellow,
                      ),
                      historyPressure(
                        sys: '171',
                        dia: '77',
                        status: 'สูงระดับ 2',
                        date: '22/09/2019',
                        time: '08:30',
                        avg: '66',
                        colorStatus: Colors.red,
                      ),
                      historyPressure(
                        sys: '120',
                        dia: '80',
                        status: 'สูงกว่าปกติ',
                        date: '22/09/2019',
                        time: '08:30',
                        avg: '80',
                        colorStatus: Colors.yellow,
                      ),
                      historyPressure(
                        sys: '133',
                        dia: '97',
                        status: 'สูงระดับ 1',
                        date: '23/09/2019',
                        time: '08:30',
                        avg: '71',
                        colorStatus: Colors.orangeAccent,
                      ),
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

Widget historyPressure({
  String sys,
  String dia,
  String status,
  String date,
  String time,
  String avg,
  Color colorStatus,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorStatus,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    sys,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: _kanit,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                      height: 2,
                    ),
                  ),
                  Text(
                    dia,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: _kanit,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  status,
                  style: TextStyle(
                    fontFamily: _kanit,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      date,
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      ',',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      time,
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '|',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      avg,
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'bpm',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: _kanit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.black,
          thickness: 1,
        ),
      ],
    ),
  );
}