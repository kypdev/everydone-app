import 'dart:math';
import 'package:everydone_app/views/bottom_nav.dart';
import 'package:everydone_app/views/home_screen.dart';
import 'package:everydone_app/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double intialradius = 30.0;
  double radius = 0.0;

  @override
  void initState() {

    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
      if (currentUser == null)
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen()))
        }
      else
        {
          Firestore.instance
              .collection("users")
              .document(currentUser.uid)
              .get()
              .then((DocumentSnapshot result) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BottomNav(
                        )));
            dispose();
          })
              .catchError((err) => print(err))
        }
    })
        .catchError((err) => print(err));

    //============================================================================

    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);

    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_radius_in = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_radius_out = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animation_radius_in.value * intialradius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animation_radius_out.value * intialradius;
        }
      });
    });

    controller.repeat();



    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Container(
            width: 100.0,
            height: 100.0,
            child: Center(
              child: RotationTransition(
                turns: animation_rotation,
                child: Stack(
                  children: <Widget>[
                    Dot(
                      radius: 30.0,
                      color: Colors.black12,
                    ),
                    Transform.translate(
                      offset:
                      Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                      child: Dot(
                        radius: 5.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                      child: Dot(
                        radius: 5.0,
                        color: Colors.greenAccent,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                      child: Dot(
                        radius: 5.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                      child: Dot(
                        radius: 5.0,
                        color: Colors.purple,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                      child: Dot(
                        radius: 5.0,
                        color: Colors.amber,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                      child: Dot(
                        radius: 5.0,
                        color: Colors.blue,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
                      child: Dot(
                        radius: 5.0,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
                      child: Dot(
                        radius: 5.0,
                        color: Colors.lightGreenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}