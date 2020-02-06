import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _kanit = 'Kanit';

class SymptomScreen extends StatefulWidget {
  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'อาหารที่เบื้องต้น',
          style: TextStyle(fontFamily: _kanit),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black12,
            ),
            Column(
              children: <Widget>[
                symptonMenu(
                  w: MediaQuery.of(context).size.width,
                  title: 'ปวดศีรษะ',
                  des:
                      '     ผู้ป่วยมักจะมีอาการปวดศีรษะในกรณีที่ความดันขึ้นอย่างรวดเร็วหรือเกิดภาวะ Hypertensive crisis โดยทั่วไปความดันโลหิตตัวบน Systolic จะมากกว่า 110 มม ปรอท หรือ Diastolic มากกว่า 110 มม ปรอท อาการปวดศีรษะมักจะปวดมึนๆบางคนปวดตลอดวัน ปวดมากเวลาถ่ายอุจาระ หากเป็นมากจะมีอาการคลื่นไส้อาเจียน',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget symptonMenu({
  w,
  String title,
  String des,
}) {

  _textToSpeech(){
    print('text to speech');
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: w,
      child: Card(
        
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: _kanit,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                des,
                style: TextStyle(
                  fontFamily: _kanit,
                  fontSize: 16,
                  
                ),
              ),
            ),
            SizedBox(height: 10,),

            RaisedButton(
              onPressed: (){
                _textToSpeech();
              },
              color: Colors.greenAccent,
              child: Container(
                width: w,
                child: Icon(FontAwesomeIcons.volumeUp),
              ),
            ),
          ],
        ),
      ),
      
    ),
  );
}
