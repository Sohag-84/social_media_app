import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/model/user.dart';
import 'package:social_media_app/resources/storage_method.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
      {required username,
      required email,
      required password,
      required bio,
      required Uint8List file}) async {
    String result = 'Some error occurred';
    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register user
        UserCredential _credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethod()
            .uploadImageToStorage('profile-picture', file, false);

        //add user to our database
        UserModel userModel = UserModel(
          email: email,
          uid: _credential.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore.collection('users').doc(_credential.user!.uid).set(userModel.toJson());
        result = 'registration successful';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        result = 'Write a valid email';
      } else if (e.code == 'weak-password') {
        result = 'The password should be at least 6 character';
      } else if (e.code == 'email-already-in-use') {
        result = 'The account already exists for that email.';
      }
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<String> signInUser({
    required email,
    required password,
  }) async {
    String result = 'some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        result = 'Successfully login';
      } else {
        result = 'Please enter all the field';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        result = 'Wrong password provided for that user.';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
}
