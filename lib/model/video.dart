import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentsCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbUrl;
  String profilePic;

  Video(
      {required this.username,
      required this.uid,
      required this.id,
      required this.likes,
      required this.commentsCount,
      required this.shareCount,
      required this.songName,
      required this.caption,
      required this.videoUrl,
      required this.thumbUrl,
      required this.profilePic});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "likes": likes,
        "commentsCount": commentsCount,
        "shareCount": shareCount,
        "songName": songName,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbUrl": thumbUrl,
        "profilePic": profilePic
      };

  static Video fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return Video(
        username: snap["username"],
        uid: snap["uid"],
        id: snap["id"],
        likes: snap["likes"],
        commentsCount: snap["commentsCount"],
        shareCount: snap["shareCount"],
        songName: snap["songName"],
        caption: snap["caption"],
        videoUrl: snap["videoUrl"],
        thumbUrl: snap["thumbUrl"],
        profilePic: snap["profilePic"]);
  }
}
