import 'package:cloud_firestore/cloud_firestore.dart';

class PostComment {
  String username;
  String comment;
  final datePub;
  List likes;
  String profilePic;
  String uid;
  String id;

  PostComment({
    required this.comment,
    required this.username,
    required this.likes,
    required this.profilePic,
    required this.uid,
    required this.id,
    this.datePub,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "comment": comment,
      "likes": likes,
      "profilePic": profilePic,
      "uid": uid,
      "id": id,
      "datePub": datePub,
    };
  }

  static PostComment fromSnap(DocumentSnapshot snap) {
    var snapshop = snap.data() as Map<String, dynamic>;
    return PostComment(
      comment: snapshop["comment"],
      username: snapshop["username"],
      likes: snapshop["likes"],
      profilePic: snapshop["profilePic"],
      uid: snapshop["uid"],
      id: snapshop["id"],
      datePub: snapshop["datePub"],
    );
  }
}
