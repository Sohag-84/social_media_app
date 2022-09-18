// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/model/user.dart';
import 'package:social_media_app/provider/user_provider.dart';
import 'package:social_media_app/resources/firestore_methods.dart';
import 'package:social_media_app/screens/news_feed_screen.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comment"),
        leading: IconButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsFeedScreen(),
                  ),
                ),
            icon: Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap['postId'])
            .collection('comments')
            .orderBy('datePublished') //so that comments are set serial wise
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data as dynamic).docs.length,
            itemBuilder: (context, index) => CommentCard(
                snap: (snapshot.data as dynamic).docs[index].data()),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(left: 18, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  userModel.photoUrl,
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8.0),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${userModel.username}',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods().postComment(
                    postId: widget.snap['postId'],
                    text: _commentController.text,
                    uid: userModel.uid,
                    name: userModel.username,
                    profilePic: userModel.photoUrl,
                  );
                  _commentController.clear();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
