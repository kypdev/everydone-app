import 'package:everydone_app/views/food_reccommend.dart';
import 'package:everydone_app/views/symptom_screen.dart';
import 'package:flutter/material.dart';
final _kanit = 'Kanit';
class ReccommendScreen extends StatefulWidget {
  @override
  _ReccommendScreenState createState() => _ReccommendScreenState();
}

class _ReccommendScreenState extends State<ReccommendScreen> {
  _foodReccomment(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FoodReccommend()));
  }

  _symptom(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SymptomScreen(),),);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black12,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25,),
                GestureDetector(
                  onTap: (){
                    _symptom();
                  },
                                  child: reccomList(
                    w: MediaQuery.of(context).size.width,
                    title: 'อาการเบื้องต้นของโรคความดันโลหิตสูง',
                    img: 'assets/images/p1.jpg',
                  ),
                ),

                SizedBox(height: 10),

                GestureDetector(
                  onTap: (){
                    _foodReccomment();
                  },
                  child: reccomList(
                            w: MediaQuery.of(context).size.width,
                    title: 'อาหารที่แนะนำ',
                    img: 'assets/images/p2.jpg',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget reccomList({w, String title, String img,}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 15,
      right: 15,
    ),
    child: Card(
      elevation: 5,
      child: Container(
        width: w,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: _kanit,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Container(
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
            )
          ],
        ),
      ),
    ),
  );
}