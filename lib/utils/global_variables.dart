import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marvel/screens/add_post_screen.dart';
import 'package:marvel/screens/feed_screen.dart';
import 'package:marvel/screens/profile_screen.dart';
import 'package:marvel/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  Text('notif'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
