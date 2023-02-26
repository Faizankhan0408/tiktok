import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/controller/auth_controller.dart';

class ProfileController extends GetxController{

  final Rx<Map<String,dynamic>> _user=Rx<Map<String,dynamic>>({});
  Rx<String> _uid="".obs;
  final Rx<bool> _isFollowing=false.obs;
  bool get isFollowing=>_isFollowing.isFalse;

  Map<String,dynamic> get user=>_user.value;

  updateUserId(String uid){
    _uid.value = uid;
    getUserData();
  }

  getUserData()async{
    List<String> thumbnails =[];

    var myVideos= await firestore.collection("videos").where("uid",isEqualTo:_uid.value).get();
    for(var element in myVideos.docs){
      thumbnails.add((element.data() as dynamic)['thumbUrl']);
    }

    DocumentSnapshot userDoc=await firestore.collection("users").doc(_uid.value).get();

    final userData=userDoc.data() as dynamic;

    String name=userData['name'];
    String profilePic=userData['profilePhoto'];
    int likes=0;
    int followers=0;
    int following=0;


    for(var element in myVideos.docs){
      likes+=(element.data()['likes'] as List).length;
    }

    var followerDocs =await firestore.collection("users").doc(_uid.value).collection("followers").get();
    var followingDocs =await firestore.collection("users").doc(_uid.value).collection("followings").get();

    followers=followerDocs.docs.length;
    following=followingDocs.docs.length;

     firestore.collection("users").doc(_uid.value).collection("followings").doc(auth.currentUser!.uid).get().then((value){
       if(value.exists){
         //already following
         _isFollowing.value=true;
       }
       else{
         // not a follower
         _isFollowing.value=false;
       }
     });

    _user.value={
      'followers':followers.toString(),
      'followings':following.toString(),
      'likes':likes.toString(),
      'name':name,
      'profilePic':profilePic,
      'isFollowing':isFollowing,
      'thumbnails':thumbnails,
    };

    update();
  }
  followUser()async{
    // checking either he is following or not
    var doc=await firestore.collection("users").doc(_uid.value).collection("followers").doc(auth.currentUser!.uid).get();

    if(!doc.exists){
      // if user is not a follower then show them in follower list
      await firestore.collection("users").doc(_uid.value).collection("followers").doc(auth.currentUser!.uid).set({});

      await firestore.collection("users").doc(auth.currentUser!.uid).collection("followings").doc(_uid.value).set({});

      _user.value.update("followers", (value) => (int.parse(value)+1).toString());
    }
    else{ // unfollow that user and remove him from our list
      await firestore.collection("users").doc(_uid.value).collection("followers").doc(auth.currentUser!.uid).delete();

      await firestore.collection("users").doc(auth.currentUser!.uid).collection("followings").doc(_uid.value).delete();

      _user.value.update("followers", (value) => (int.parse(value)-1).toString());
    }
    // reverting value of isFollowing to opposite one
    _user.value.update("isFollowing", (value) =>!value);
  }
}