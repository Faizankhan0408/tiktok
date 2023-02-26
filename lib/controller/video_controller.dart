import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/controller/auth_controller.dart';
import 'package:tiktok/model/video.dart';

class videoController extends GetxController{
  final Rx<List<Video>> _videoList=Rx<List<Video>>([]);

  late Rx<User> _user;
  User get user => _user.value!;

  List<Video> get videoList=> _videoList.value;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videoList.bindStream(firestore.collection("videos").snapshots().map((QuerySnapshot query ) {
      List<Video> retVal=[];
      for(var ele in query.docs){
        retVal.add(Video.fromSnap(ele));
      }
      return retVal;
    }));
  }

  likedVideo(String id) async{
    DocumentSnapshot snapshot=await firestore.collection("videos").doc(id).get();
   var uid=AuthController.instance.user.uid!;
   if((snapshot.data() as dynamic)['likes'].contains(uid)){
     await firestore.collection("videos").doc(id).update(
       {
         "likes":FieldValue.arrayRemove([uid])
       }
     );
   }
   else{
     await firestore.collection("videos").doc(id).update(
       {
         'likes':FieldValue.arrayUnion([uid])
       });
   }
  }
  shareVideo(String id) async{
    var snap=await firestore.collection("videos").doc(id).get();
    int shareCount=(snap.data() as dynamic)['shareCount']+1;
    await firestore.collection("videos").doc(id).update({
      'shareCount':shareCount
    });

  }

}