// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/utils/colors.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(left: 2),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    snap['profileImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          child: ListView(
                            shrinkWrap: true,
                            children: ["Delete"]
                                .map(
                                  (e) => InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 16),
                                      child: Text(e.toString()),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          //image section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
            child: SizedBox(
              height: height * 0.35,
              width: width,
              child: Image.network(
                snap['postUrl'],
                //fit: BoxFit.fill,
              ),
            ),
          ),
          //Like comment section
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.bookmark_border),
                  ),
                ),
              ),
            ],
          ),
          //description and number of colums
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 6, right: 6),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: snap['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        //for padding two textSpan
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                          ),
                        ),
                        TextSpan(
                          text: snap['description'],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all 200 comments',
                      style: TextStyle(color: secondaryColor, fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(snap['datePublished'].toDate()),
                    style: TextStyle(color: secondaryColor, fontSize: 10),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
