import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _kanit = 'Kanit';

class FoodReccommend extends StatefulWidget {
  @override
  _FoodReccommendState createState() => _FoodReccommendState();
}
enum TtsState { playing, stopped }
class _FoodReccommendState extends State<FoodReccommend> {

  FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

//    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak(String desc) async {
    await flutterTts.isLanguageAvailable("th-TH");
    if (desc != null) {
      if (desc.isNotEmpty) {
        var result = await flutterTts.speak(desc);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
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
      body: Stack(
        children: <Widget>[

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black12,
          ),

          SafeArea(
            child: Center(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("reccommendFoods")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                    top: 20,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
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
                                                image: NetworkImage(document['img']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '${document['title']}',
                                            style: TextStyle(
                                                fontFamily: _kanit, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: Text(
                                              '     ${document['desc']}',
                                              style: TextStyle(
                                                fontFamily: _kanit,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.volumeUp,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () =>
                                                    _speak(document['desc']),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  FontAwesomeIcons.volumeMute,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () => _stop,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
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
    padding: const EdgeInsets.only(top: 8, bottom: 8),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 20,
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
                      image: NetworkImage(img),
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