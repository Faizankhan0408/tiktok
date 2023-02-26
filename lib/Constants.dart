import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/view/screens/add_video.dart';
import 'package:tiktok/view/screens/display_video_screen.dart';
import 'package:tiktok/view/screens/profile_screen.dart';
import 'package:tiktok/view/screens/search_screen.dart';

// Colors
const backgroundColor =Colors.black;
var buttonColor =Colors.red[400];
const borderColor =Colors.grey;

getRandomColor() => [
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent,
][Random().nextInt(3)];


var firestore=FirebaseFirestore.instance;
var firebaseStorage=FirebaseStorage.instance;
var auth=FirebaseAuth.instance;

var pageIndices = [
DisplayVideoScreen(),
SearchScreen(),
addVideoScreen(),
Text('Messages coming soon..'),
ProfileScreen(uid: auth.currentUser!.uid,)];
