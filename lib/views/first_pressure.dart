import 'package:flutter/material.dart';

import 'bottom_nav.dart';

final _kanit = 'Kanit';

class FirstPressure extends StatefulWidget {
  @override
  _FirstPressureState createState() => _FirstPressureState();
}

class _FirstPressureState extends State<FirstPressure> {
  TextEditingController _sysCtrl = new TextEditingController();
  TextEditingController _diaCtrl = new TextEditingController();

  _personPressure() {
    String _sys = _sysCtrl.text.trim();
    String _dia = _diaCtrl.text.trim();
    print('SYS : ' + _sys);
    print('DIA : ' + _dia);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNav(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ความดันปกติ',
          style: TextStyle(fontFamily: _kanit),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _sysCtrl,
                          decoration: InputDecoration(
                            labelText: 'SYS',
                            labelStyle: TextStyle(
                              fontFamily: _kanit,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _diaCtrl,
                          decoration: InputDecoration(
                            labelText: 'DIA',
                            labelStyle: TextStyle(
                              fontFamily: _kanit,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(0, 255, 0, 20),
                                Color.fromRGBO(220, 200, 0, 10)
                              ],
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              _personPressure();
                            },
                            child: Text(
                              'ตกลง',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: _kanit,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
