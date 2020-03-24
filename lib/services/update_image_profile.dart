
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateImageProfile {
  Future updatePro(imgUrl, context) {
    var userInfo = UserUpdateInfo();
    userInfo.photoUrl = imgUrl;
    FirebaseAuth.instance.currentUser().then((user) {
      user.updateProfile(userInfo);
      Firestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
            Firestore.instance
                .document('users/${docs.documents[0].documentID}')
                .updateData({'imgProfile': imgUrl}).then((val) {
              print('ok');
            }).then((user) {
              print('ok wow');
            }).catchError((e) {
              print('can\'t change pages ${e}');
            });
          })
          .catchError((e) {
            print('users error ${e}');
          })
          .catchError((e) => print('update pic ${e}'))
          .catchError((e) => print('first ${e}'));
    });
  }
}
