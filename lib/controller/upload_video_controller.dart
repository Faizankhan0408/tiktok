import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/model/user.dart';
import 'package:tiktok/view/screens/add_captionscreen.dart';
import 'package:tiktok/view/screens/home_screen.dart';
import 'package:uuid/uuid.dart';
// import '/models/video.dart';
import 'package:video_compress/video_compress.dart';

import '../model/video.dart';

class UploadVideoController extends GetxController {
  static UploadVideoController instance=Get.find();

  var uuid=Uuid();
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot userDoc =
      await firestore.collection('users').doc(uid).get();
      // get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String key=uuid.v1();

      String videoUrl = await _uploadVideoToStorage(key, videoPath);
      String thumbnail = await _uploadImageToStorage(key, videoPath);

      Video video=Video(
        id: key,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbUrl: thumbnail,
        shareCount: 0,
        commentsCount: 0,
        likes: [],
        uid: uid,
        profilePic: myUser.fromSnap(userDoc).profilePhoto,
        username: myUser.fromSnap(userDoc).name,
      );

      //uploading video
      await firestore.collection('videos').doc(key).set(video.toJson());

      Get.snackbar("Video uploaded","Thanks for sharing your video");
      Get.offAll(HomeScreen());

    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}