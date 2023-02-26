import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/model/user.dart';

class SearchController extends GetxController{
  Rx<List<myUser>> _users=Rx<List<myUser>>([]);

  List<myUser> get users=>_users.value;


  fetchUsers(String query) async{
    _users.bindStream(
        firestore.collection('users').where('name',isGreaterThanOrEqualTo: query).snapshots().map((QuerySnapshot snap){
          List<myUser> retVal=[];
          for(var ele in snap.docs){
            retVal.add(myUser.fromSnap(ele));
          }
          return retVal;
        })
    );
  }
}