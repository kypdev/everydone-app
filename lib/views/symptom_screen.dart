import 'package:everydone_app/commons/symtom_card.dart';
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

  Widget symptonMenu({
    w,
    String title,
    String des,
  }) {
    _textToSpeechPlay() {
      print('text to speech play');
    }

    _textToSpeechPause() {
      print('text to speech pause');
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: w,
        child: Container(
          color: Colors.white,
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
                  '     ${des}',
                  style: TextStyle(
                    fontFamily: _kanit,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.volumeUp,
                        color: Colors.grey,
                      ),
                      onPressed: _textToSpeechPlay,
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.volumeMute,
                        color: Colors.grey,
                      ),
                      onPressed: _textToSpeechPause,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
