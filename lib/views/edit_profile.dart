import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everydone_app/views/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final String _kanit = 'Kanit';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String image;
  String userID = '';
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

  _signout() {
    FirebaseAuth.instance
        .signOut()
        .then((result) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SigninScreen())))
        .catchError((err) => print(err));
  }

  @override
  void initState() {
    inputData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'โปรไฟล์',
          style: TextStyle(fontFamily: _kanit),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: StreamBuilder(
        stream:
            Firestore.instance.collection('users').document(userID).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return profile(
            email: snapshot.data['email'],
            firstname: snapshot.data['FirstName'],
            img: snapshot.data['imgProfile'],
            lastname: snapshot.data['LastName'],
          );
        },
      ),
    );
  }

  Widget profile({img, firstname, lastname, email}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12),
            Center(
              child: Container(
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
            ),
            SizedBox(height: 12),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(firstname,style: TextStyle(fontFamily: _kanit, fontSize: 22.0),),
//                SizedBox(width: 20.0),
//                Text(lastname,style: TextStyle(fontFamily: _kanit, fontSize: 22.0),),
//              ],
//            ),
            SizedBox(height: 12),
            _form(
              title: 'ชื่อ',
              content: firstname,
            ),
            _form(
              title: 'นามสกุล',
              content: lastname,
            ),
            _form(
              title: 'อีเมลล์',
              content: email,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'ออกจากระบบ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: _kanit,
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: _signout,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20.0,
                      // has the effect of softening the shadow
                      spreadRadius: 4.0,
                      // has the effect of extending the shadow
                      offset: Offset(
                        8.0, // horizontal, move right 10
                        8.0, // vertical, move down 10
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 0, 100, 20),
                      Color.fromRGBO(250, 150, 0, 10)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _form({
    title,
    content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: _kanit,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontFamily: _kanit,
              fontSize: 18.0,
              color: Colors.black54,
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
