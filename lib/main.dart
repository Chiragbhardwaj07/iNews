import 'package:flutter/material.dart';
import 'package:inews/pages/Home_Page.dart';
import 'package:inews/pages/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/home': (context) => Home_Page(),
      },
    );
  }
}
