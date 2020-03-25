import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final String _kanit = 'Kanit';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String image;
  String userID = '';
  Firestore _firestore = Firestore.instance;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshots;
  String img, fname, lname, emails;

  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid.toString();
    });
  }

  Future readFirestore() async {
    CollectionReference collectionReference = _firestore.collection('users');

    subscription = await collectionReference.snapshots().listen((d) {
      snapshots = d.documents;

      for (var snap in snapshots) {
        String imgPro = snap.data['imgProfile'];
        String firstname = snap.data['FirstName'];
        String lastname = snap.data['LastName'];
        String email = snap.data['email'];
        setState(() {
          img = imgPro.toString();
          fname = firstname.toString();
          lname = lastname.toString();
          emails = email.toString();
        });
        print(
            'firstname: ${fname}, lastname: ${lname}, email: ${emails} img: ${imgPro}, ');
      }
    });
  }

  Future<DocumentReference> getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    DocumentReference ref = _firestore.collection('users').document(user.uid);
    print(ref);
  }

  @override
  void initState() {
    inputData();
    super.initState();
    readFirestore();
    getUserDoc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แก้ไขโปรไฟล์',
          style: TextStyle(fontFamily: _kanit),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black12,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('users')
                        .document(userID)
                        .snapshots(),
                    builder: (context, sn) {
                      var img = sn.data['imgProfile'];
                      var firstname = sn.data['FirstName'].toString();
                      return profile(
                        img: img,
                        firstname: firstname,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profile({
    img,
    firstname,
  }) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(height: 12),
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 5),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    img,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(firstname)
          ],
        ),
      ),
    );
  }
}
