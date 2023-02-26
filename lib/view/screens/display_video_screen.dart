import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/controller/video_controller.dart';
import 'package:tiktok/view/screens/comment_screen.dart';
import 'package:tiktok/view/screens/profile_screen.dart';
import 'package:tiktok/view/widgets/album_rotater.dart';

import '../widgets/profile_button.dart';
import '../widgets/tiktok_videoplayer.dart';

class DisplayVideoScreen extends StatelessWidget {
   DisplayVideoScreen({Key? key}) : super(key: key);

  final controller=Get.put(videoController());

   Future<void> share(String vidId) async {
     await FlutterShare.share(
         title: 'Download my tik tok app',
         text: 'Watch amazing videos on it',
     );
     controller.shareVideo(vidId);
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
          return PageView.builder(
              itemCount: controller.videoList.length,
              controller: PageController(initialPage: 0, viewportFraction: 1),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data=controller.videoList[index];
                return InkWell(
                  onDoubleTap: (){
                    controller.likedVideo(data.id);
                  },
                  child: Stack(
                    children: [
                      TikTokVideoPlayer(videoUrl:data.videoUrl),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            Text(
                             data.username,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(data.songName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20)),
                            Text(data.caption,style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height-350,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3,right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: (){
                                    Get.to(()=>ProfileScreen(uid: data.uid));
                                  },
                                  child: ProfileButton(profileUrl: data.profilePic)),
                              //like
                              InkWell(
                                onTap:(){
                                  controller.likedVideo(data.id);
                                },
                                child: Column(
                                  children:  [
                                     Icon(
                                      Icons.favorite,
                                      size: 35,
                                      color:data.likes.contains(auth.currentUser!.uid)? Colors.pinkAccent:Colors.white,
                                    ),
                                    Text(
                                     data.likes.length.toString(),
                                      style: const TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),

                              //share
                              InkWell(
                                onTap: (){
                                  share(data.id);

                                },
                                child: Column(
                                  children:  [
                                    const Icon(
                                      Icons.reply,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    Text(
                                     data.shareCount.toString(),
                                      style: const TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),


                              //comments
                              InkWell(
                                onTap:(){
                                  Get.to(CommentScreen(id:data.id));
                                },
                                child: Column(
                                  children:  [
                                    const Icon(
                                      Icons.comment,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      data.commentsCount.toString(),
                                      style: const TextStyle(fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),

                              AlbumRotator(profilePicUrl: data.profilePic),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        }
      ),
    );
  }
}
