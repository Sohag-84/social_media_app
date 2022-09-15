// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/model/user.dart';
import 'package:social_media_app/provider/user_provider.dart';
import 'package:social_media_app/resources/firestore_methods.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _file;

  bool isLoading = false;

  postImage(String uid, String username, String profileImage) async {
    setState(() {
      isLoading = true;
    });
    try {
      String result = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profileImage,
      );
      if(result== 'success'){
        setState(() {
          isLoading = false;
        });
        clearImage();
        Fluttertoast.showToast(msg: 'Post uploaded');
      }else{
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: result);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Create a post"),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Choose image from gallery"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  clearImage(){
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.upload,
                ),
                onPressed: () => selectImage(context),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => clearImage(),
              ),
              title: Text('Post to'),
              actions: [
                TextButton(
                  onPressed: ()=> postImage(user.uid, user.username, user.photoUrl),
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                isLoading? LinearProgressIndicator(): Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          user.photoUrl,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.45,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                // image: NetworkImage(
                                //   'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                                // ),
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );
  }
}
