import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/model/post_model.dart';
import 'package:social_media_app/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profileImage) async {
    String result = "Some error occurred";
    try {
      final photoUrl =
          await StorageMethod().uploadImageToStorage('Post', file, true);
      String postId = const Uuid().v1(); //// Generate a v1 (time-based) id
      PostModel post = PostModel(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profileImage: profileImage,
          likes: [],);
      firestore.collection('posts').doc(postId).set(post.toJson(),);
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
}
