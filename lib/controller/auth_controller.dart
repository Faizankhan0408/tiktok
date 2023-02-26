import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/model/user.dart';
import 'package:tiktok/view/screens/auth/login_screen.dart';
import 'package:tiktok/view/screens/auth/sign_up.dart';

import '../Constants.dart';
import '../view/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? proImage;

  // image picker

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imagePath = File(image.path);
    proImage = imagePath;
  }


  // user state persistence
  late Rx<User?>_user;
  User get user => _user.value!;

  @override
  void onReady() {  //similar like intiState
    super.onReady();
    _user=Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }

  _setInitialView(User? user){
    if(user==null){
      Get.offAll(LoginScreen());
    }
    else{
      Get.offAll( HomeScreen());
    }
  }

  // register user
  void SignUp(
      String username, String email, String password, File? imageFile) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          imageFile != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String imageUrl = await _uploadProPic(imageFile);

        myUser user = myUser(
            name: username,
            email: email,
            uid: credential.user!.uid,
            profilePhoto: imageUrl);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
            "Error Creating Account", "Please enter all the required fields");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar("Error", e.toString());
    }
  }

  Future<String> _uploadProPic(File image) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("profilePics")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error", "Please enter all the required fields");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    }
  }

  signout(){
    auth.signOut();
    Get.offAll(LoginScreen());
  }
}
