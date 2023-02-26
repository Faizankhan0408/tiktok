import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/view/screens/add_captionscreen.dart';

class addVideoScreen extends StatelessWidget {
  const addVideoScreen({Key? key}) : super(key: key);

  videoPicker(ImageSource src) async{
    final video=await ImagePicker().pickVideo(source: src);
    if(video!=null) {
      Get.to(addCaptionScreen(videoFile: File(video.path), videoPath: video.path));
    }
    else{
      Get.snackbar("Error", "Please select different video");
    }
  }

  showDialogOpt(BuildContext context){
    return showDialog(
      context: context,
      builder: (context)=>
      // todo: styling simple dialog box
          SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed:(){
                  videoPicker(ImageSource.gallery);
                },
                child: const Text('Gallery'),
              ),
              SimpleDialogOption(
                onPressed:(){
                  videoPicker(ImageSource.camera);
                },
                child: const Text('Camera'),
              ),
              SimpleDialogOption(
                onPressed:(){
                     Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: ()=>showDialogOpt(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(7)
            ),
            child: const Center(
              child: Text("Add video",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
