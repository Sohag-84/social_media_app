import 'package:flutter/material.dart';

class WebScreeLayout extends StatelessWidget {
  const WebScreeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is web screen",style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
