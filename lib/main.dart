// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/responsive/mobile_screen_layout.dart';
import 'package:social_media_app/responsive/responsive_layout_screen.dart';
import 'package:social_media_app/responsive/web_screen_layout.dart';
import 'package:social_media_app/screens/login_screen.dart';
import 'package:social_media_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBg_1mt_Y3SLEKL1UCe4iXTlbejRAwVXZ0',
        appId: "1:814632063128:web:ada19b495a6fe98aea80ed",
        messagingSenderId: "814632063128",
        projectId: "social-media-app-f7098",
        storageBucket: "social-media-app-f7098.appspot.com",
      ),
    );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social app',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              return ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              );
            }else if(snapshot.hasError){
              Fluttertoast.showToast(msg: snapshot.error.toString());
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: primaryColor,),);
          }
          return LoginScreen();
        },
      ),
    );
  }
}
