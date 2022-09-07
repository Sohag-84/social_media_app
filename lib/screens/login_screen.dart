// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/resources/auth_method.dart';
import 'package:social_media_app/responsive/mobile_screen_layout.dart';
import 'package:social_media_app/responsive/responsive_layout_screen.dart';
import 'package:social_media_app/responsive/web_screen_layout.dart';
import 'package:social_media_app/screens/signup_screen.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  clearTextField() {
    _emailController.clear();
    _passwordController.clear();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethod().signInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (result != 'success') {
      Fluttertoast.showToast(msg: result);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
      clearTextField();
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SignUpScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              SizedBox(height: 65),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPassword: true,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 35),
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  alignment: Alignment.center,
                  child: _isLoading
                      ? Center(
                          child: Text("Please wait..."),
                        )
                      : Text("Log in"),
                  decoration: ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Don't have an account?"),
                  ),
                  InkWell(
                    onTap: () {
                      navigateToSignup();
                      clearTextField();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(" Sign up"),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
