import 'package:flutter/material.dart';

final _kanit = 'Kanit';

class FoodReccommend extends StatefulWidget {
  @override
  _FoodReccommendState createState() => _FoodReccommendState();
}

class _FoodReccommendState extends State<FoodReccommend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'อาหารที่แนะนำ',
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
                foodMenu(
                  w: MediaQuery.of(context).size.width,
                  img: 'assets/images/f1.jpg',
                  title: 'ถั่วขาว',
                  des:
                      '       ถั่วขาว มีคุณค่าทางโภชนาการอาหารที่จำเป็น เช่น คาร์โบไฮเดรต วิตามิน มีกากและเส้นใยอาหารและมีสารช่วยยับยั้งการทำงานของเอนไซม์แอลฟ่า-อะไมเลส ทำให้ลดการสะสมแป้งในร่างกาย',
                ),
                foodMenu(
                  w: MediaQuery.of(context).size.width,
                  img: 'assets/images/f2.jpg',
                  title: 'ถั่วขาว',
                  des:
                      '       เนื้อสันใน ควรเลือกทานตรงส่วนที่ไม่ติดมัน เพราะเนื้อในส่วนนี้จะอุดมไปด้วยโพแทสเซียมร้อยละ 15 และยังมีคอเลสเตอ  รอลน้อยกว่า ส่วนที่ติดมัน',
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget foodMenu({
  w,
  String img,
  String title,
  String des,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Container(
            width: w,
            child: Column(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(5),
                      topRight: const Radius.circular(5),
                      bottomLeft: const Radius.circular(5),
                      bottomRight: const Radius.circular(5),
                    ),
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: _kanit, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    des,
                    style: TextStyle(
                      fontFamily: _kanit,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}