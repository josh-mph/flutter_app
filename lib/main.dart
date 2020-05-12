import 'package:barber_homepro/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(canvasColor:Color(0xFF28152a),fontFamily: 'Josefin Sans'),
      home:SplashScreen(),
    );
  }
}