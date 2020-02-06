import 'package:flutter/material.dart';

final _kanit = 'Kanit';

class ChooseDevice extends StatefulWidget {
  @override
  _ChooseDeviceState createState() => _ChooseDeviceState();
}

class _ChooseDeviceState extends State<ChooseDevice> {
  TextEditingController _typeCtrl = new TextEditingController();
  TextEditingController _detailCtrl = new TextEditingController();

  _sendDeviceName(){
    print('send device name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เลือกเครื่องวัดความดันโลหิต',
          style: TextStyle(fontFamily: _kanit),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black12,
          ),
          ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              listDevice(
                w: MediaQuery.of(context).size.width,
                img: 'assets/images/device.jpg',
                deviceName: 'YuWell YE670A',
              ),
              listDevice(
                w: MediaQuery.of(context).size.width,
                img: 'assets/images/device.jpg',
                deviceName: 'YuWell YE670A',
              ),
              listDevice(
                w: MediaQuery.of(context).size.width,
                img: 'assets/images/device.jpg',
                deviceName: 'YuWell YE670A',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 20),
                        child: Text(
                          'รุ่นอื่น ๆ',
                          style: TextStyle(
                            fontFamily: _kanit,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 20),
                        child: Row(
                          children: <Widget>[
                            Text('ยี่ห้อ : ', style: TextStyle(fontFamily: _kanit),),
                            Expanded(
                              child: TextFormField(
                                controller: _typeCtrl,
                                decoration: InputDecoration(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 20),
                        child: Row(
                          children: <Widget>[
                            Text('รุ่น : ', style: TextStyle(fontFamily: _kanit),),
                            Expanded(
                              child: TextFormField(
                                controller: _detailCtrl,
                                decoration: InputDecoration(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.greenAccent,
                                Colors.lightGreenAccent,
                              ],
                            ),

                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: MaterialButton(
                            onPressed: (){
                              _sendDeviceName();
                            },
                            child: Text('ยืนยัน', style: TextStyle(
                              color: Colors.white,
                              fontFamily: _kanit,
                            ),),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),
                    ],
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

Widget listDevice({
  w,
  String img,
  String deviceName,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            img,
            height: 100,
          ),
          SizedBox(
            width: 50,
          ),
          Text(
            deviceName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: _kanit,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}
