import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

import '../../controller/upload_video_controller.dart';

class addCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;

  addCaptionScreen({Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<addCaptionScreen> createState() => _addCaptionScreenState();
}

class _addCaptionScreenState extends State<addCaptionScreen> {
late VideoPlayerController _controller;

var videoController=Get.put(UploadVideoController());

TextEditingController songNameController=TextEditingController();
TextEditingController captionNameController=TextEditingController();

Widget UploadContent=Text("Upload", style: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 15,
));

uploadVideo(){
  UploadContent=Text("Please wait");
  setState(() {

  });
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _controller=VideoPlayerController.file(widget.videoFile);
    });
    _controller.initialize();
    _controller.play();
    _controller.setLooping(true);
    _controller.setVolume(0.7);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/1.6,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(_controller),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputFiled(controller: songNameController,
                      myLabelText: "Song name",
                      myIcon: Icons.music_note),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputFiled(controller: captionNameController,
                      myLabelText: "Caption",
                      myIcon: Icons.closed_caption),
                  SizedBox(height: 10,),

                  // adding upload button
                  InkWell(
                    onTap: (){
                      uploadVideo();
                      videoController.uploadVideo(songNameController.text, captionNameController.text, widget.videoPath);
                    },
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child:  Center(
                        child: UploadContent,
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
