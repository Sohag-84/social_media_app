// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_media_app/screens/login_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text("This is mobile screen"),),
      ),
    );
  }
}
