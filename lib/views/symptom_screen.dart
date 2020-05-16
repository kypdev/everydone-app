import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

final _kanit = 'Kanit';

class SymptomScreen extends StatefulWidget {
  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

enum TtsState { playing, stopped }

class _SymptomScreenState extends State<SymptomScreen> {

  FlutterTts flutterTts;
  dynamic languages;
  String language;
  TtsState ttsState = TtsState.stopped;



  initTts(){
    flutterTts = FlutterTts();
    _getLanguages();

  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _speak(desc) async {
    var result = await flutterTts.speak(desc);
    // if (result == 1) setState(() => ttsState = TtsState.playing);

  }

  Future _stop() async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void initState() {
    super.initState();
    initTts();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }


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
                      .collection("DiseaseSymptoms")
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
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        document['title'],
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          '     ${document['desc']}',
                                          style: TextStyle(
                                            fontFamily: _kanit,
                                            fontSize: 16,
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
                                            onPressed: () {
                                              _speak(document['desc']);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.volumeMute,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              _stop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
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
