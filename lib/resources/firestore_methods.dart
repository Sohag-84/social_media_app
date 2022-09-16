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
        likes: [],
      );
      firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      result = 'success';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<void> likePost({required String postId, required String uid, required List likes}) async {
    try {
      if (likes.contains(uid)) {
       await firestore.collection('posts').doc(postId).update(
          {
            'likes': FieldValue.arrayRemove([uid]), // if user already liked then second click user dislike
          },
        );
      }else{
       await firestore.collection('posts').doc(postId).update(
          {
            'likes': FieldValue.arrayUnion([uid]), // if user already doesn't liked then second click user like
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
