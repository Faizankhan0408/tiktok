import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/model/comment.dart';

class CommentController extends GetxController {

  final Rx<List<PostComment>> _comments = Rx<List<PostComment>>([]);

  List<PostComment> get comments => _comments.value;

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    fetchComment();
  }

  fetchComment() async {
    _comments.bindStream(
        firestore.collection("videos").doc(_postId).collection("comments")
            .snapshots()
            .map((QuerySnapshot query) {
          List<PostComment> retVal = [];
          for (var ele in query.docs) {
            retVal.add(PostComment.fromSnap(ele));
          }
          return retVal;
        }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc =
        await firestore.collection("users").doc(
            auth.currentUser!.uid.toString()).get();
        var allDocs = await firestore
            .collection("videos")
            .doc(_postId)
            .collection("comments")
            .get();
        int len = allDocs.docs.length;
        PostComment comment = PostComment(
          comment: commentText,
          username: (userDoc.data() as dynamic)["name"],
          likes: [],
          profilePic: (userDoc.data() as dynamic)["profilePhoto"],
          uid: auth.currentUser!.uid,
          id: 'Comments $len',
          datePub: DateTime.now(),
        );

        DocumentSnapshot doc = await firestore.collection("videos")
            .doc(_postId)
            .get();
        await firestore.collection('videos').doc(_postId).update({
          'commentsCount': (doc.data() as dynamic)["commentsCount"] + 1,
        });

        await firestore.collection("videos").doc(_postId)
            .collection("comments")
            .doc('Comments $len')
            .set(comment.toJson());
      }
    } catch (e) {
      Get.snackbar("error: ", e.toString());
      print(e);
    }
  }

  likeComment(String id) async {
    var uid = auth.currentUser!.uid;
    DocumentSnapshot snapshot = await firestore.collection("videos").doc(
        _postId).collection("comments").doc(id).get();

    if ((snapshot.data() as dynamic)['likes'].contains(uid)) {
      await firestore.collection("videos").doc(_postId)
          .collection("comments")
          .doc(id)
          .update(
          {
            "likes": FieldValue.arrayRemove([uid])
          });
    }
    else {
      await firestore.collection("videos").doc(_postId)
          .collection("comments")
          .doc(id)
          .update(
          {
            "likes": FieldValue.arrayUnion([uid])
          });
    }
  }
}
