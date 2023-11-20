import 'package:flutter/material.dart';
import 'package:inews/pages/Home_Page.dart';
import 'package:inews/pages/category_page.dart';
import 'package:inews/utils/splashScreen.dart';
import 'package:inews/pages/test.dart';

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
        // '/test': (context) => test_page(),
      },
    );
  }
}
