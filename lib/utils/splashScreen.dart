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
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/splash.jpeg',
                    ),
                    fit: BoxFit.cover)),
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'i N E W S',
                      style: GoogleFonts.anton(
                          // letterSpacing: 0.6,
                          color: Colors.black,
                          fontSize: 28),
                    ),
                    SizedBox(
                      height: height * 0.85,
                    ),
                    SpinKitChasingDots(
                      size: 35,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
