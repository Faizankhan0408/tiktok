import 'package:cloud_firestore/cloud_firestore.dart';

class myUser{
  String name;
  String email;
  String uid;
  String profilePhoto;

  myUser({required this.name, required this.email, required this.uid, required this.profilePhoto});

  // App -> Firebase(Map)
  Map<String,dynamic> toJson()=>{
    "name" : name,
    "email" : email,
    "profilePhoto": profilePhoto,
    "uid":uid,
  };

  // Firebase -> App(snapshot)
  static myUser fromSnap(DocumentSnapshot snapshot){
    var snap=snapshot.data() as Map<String,dynamic>;
    return myUser(name: snap['name'], email: snap['email'], uid:  snap['uid'], profilePhoto:  snap['profilePhoto']);
  }

}