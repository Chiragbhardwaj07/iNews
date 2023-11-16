import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inews/utils/shareSheet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash_pic.jpg',
              fit: BoxFit.cover,
              // width: width * 0.9,
              height: height * 0.5,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              'H E A D L I N E S',
              style: GoogleFonts.anton(
                  // letterSpacing: 0.6,
                  color: Colors.grey[700],
                  fontSize: 20),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            SpinKitChasingDots(
              size: 35,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
