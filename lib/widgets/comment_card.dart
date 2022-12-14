// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({Key? key, required this.snap}) : super(key: key);

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
              widget.snap['profilePic'],
            ),
            radius: 18,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.snap['name'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.snap['text'],
                ),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: widget.snap['name'],
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       // add a space between texts
                //       WidgetSpan(
                //         child: Padding(
                //           padding: const EdgeInsets.only(left: 10.0),
                //         ),
                //       ),
                //       TextSpan(text: widget.snap['text']),
                //     ],
                //   ),
                // ),
                //for date
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
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
