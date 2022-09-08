import 'package:flutter/material.dart';
import 'package:social_media_app/model/user.dart';
import 'package:social_media_app/resources/auth_method.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final AuthMethod _authMethod = AuthMethod();

  UserModel get getUser => _user!;

  Future<void> refreshUserData() async {
    UserModel user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
