import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _kanit = 'Kanit';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String userID = '';
  Color pColor = null;

  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid;
    });
  }

  Future<DocumentSnapshot> getColor() {
    print(pColor);
    var color = Firestore.instance
        .collection('user')
        .document(userID)
        .collection('pressure')
        .document('color')
        .get();

    print(color);
  }

  @override
  void initState() {
    inputData();
    print(userID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("users")
                    .document(userID)
                    .collection('pressure')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: new Text('Loading...'));
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return history(
                            rate: document['rate'].toString(),
                            sys: document['sys'].toString(),
                            dia: document['dia'].toString(),
                            date: document['create_at'].toString(),
                            pulse: document['pulse'].toString(),
                            color: (document['color'].toString() ==
                                    'Colors.greenAccent')
                                ? pColor = Colors.greenAccent
                                : (document['color'].toString() ==
                                        'Colors.purple')
                                    ? pColor = Colors.purple
                                    : (document['color'].toString() ==
                                            'Colors.yellow')
                                        ? pColor = Colors.yellow
                                        : (document['color'].toString() ==
                                                'Colors.amber')
                                            ? pColor = Colors.amber
                                            : (document['color'].toString() ==
                                                    'Colors.amber')
                                                ? pColor = Colors.amber
                                                : pColor = Colors.red,
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ),
            RaisedButton(
              child: Text('aaa'),
              onPressed: getColor,
            ),
          ],
        ),
      ),
    );
  }
}

Widget history({
  String sys,
  String rate,
  String dia,
  String date,
  String pulse,
  Color color,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        sys,
                        style: TextStyle(
                          fontFamily: _kanit,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 2, bottom: 2),
                        child: Divider(
                          height: 3,
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        dia,
                        style: TextStyle(
                            fontFamily: _kanit,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      rate,
                      style: TextStyle(
                        fontFamily: _kanit,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          date,
                          style: TextStyle(
                            fontFamily: _kanit,
                            fontSize: 18,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          pulse,
                          style: TextStyle(
                            fontFamily: _kanit,
                            fontSize: 18,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'bpm',
                          style: TextStyle(
                            fontFamily: _kanit,
                            fontSize: 18,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
