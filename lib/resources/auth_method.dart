import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
      {required username,
      required email,
      required password,
      required bio,
      required Uint8List file}) async{
    String result = 'Some error occurred';
    try{
      if(username.isNotEmpty || email.isNotEmpty || password.isNotEmpty || bio.isNotEmpty || file != null){
        // register user
       UserCredential _credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

       //add user to our database
        await _firestore.collection('users').doc(_credential.user!.uid).set({
          'username': username,
          'uid': _credential.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
        result = 'successful';
      }

    }catch (error){
      result = error.toString();
    }
    return result;
  }
}
