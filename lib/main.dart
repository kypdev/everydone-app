import 'package:everydone_app/views/bottom_navy.dart';
import 'package:everydone_app/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'views/signin_screen.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashPage(), routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => BottomNavy(),
      '/login': (BuildContext context) => SigninScreen(),
    });
  }
}
