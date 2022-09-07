// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/resources/auth_method.dart';
import 'package:social_media_app/responsive/mobile_screen_layout.dart';
import 'package:social_media_app/responsive/responsive_layout_screen.dart';
import 'package:social_media_app/responsive/web_screen_layout.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/utils/utils.dart';
import 'package:social_media_app/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _isLoading = false;

  Uint8List? _image;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(
      () {
        _image = im;
      },
    );
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethod().signUpUser(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (result != 'success') {
      //showSnackBar(result, context);
      Fluttertoast.showToast(msg: result);
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Flexible(child: Container(), flex: 2),
                SizedBox(height: 40),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                SizedBox(height: 30),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 75,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 75,
                            backgroundImage:
                                NetworkImage('https://tinyurl.com/ycyfewpn'),
                          ),
                    Positioned(
                      bottom: -15,
                      right: -15,
                      child: IconButton(
                        onPressed: () => selectImage(),
                        icon: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 24),
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
                  textInputType: TextInputType.emailAddress,
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 24),
                TextFieldInput(
                  textEditingController: _bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 35),
                InkWell(
                  onTap: () => signUpUser(),
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    alignment: Alignment.center,
                    child: _isLoading
                        ? Center(
                            child: Text("Please wait..."),
                          )
                        : Text("Sign up"),
                    decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                //Flexible(child: Container(), flex: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Already have an account?"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(" Log in"),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
