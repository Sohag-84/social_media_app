// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_media_app/screens/add_post_screen.dart';
import 'package:social_media_app/screens/news_feed_screen.dart';
import 'package:social_media_app/screens/search_screen.dart';

const webScreenSize = 600;

//for bottom navigation bar screen
final homeScreenItem = [
  NewsFeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("Favourite"),
  Text("Persong"),
];
