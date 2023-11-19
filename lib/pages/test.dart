import 'package:flutter/material.dart';

class test_page extends StatelessWidget {
  const test_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(child: Text('this is a test page')),
    );
  }
}
