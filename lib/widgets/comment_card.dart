// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
            ),
            radius: 18,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'username',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // add a space between texts
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                        ),
                      ),
                      TextSpan(text: 'some description insert here'),
                    ],
                  ),
                ),
                //for date
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    '25/09/2022',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
