import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/controller/auth_controller.dart';

import '../../controller/profile_controller.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  String uid;

  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put(ProfileController());
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    profileController.updateUserId(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return controller.user.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: profileController.user.isEmpty
                        ? const Text("")
                        : Text(profileController.user['name']),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          Get.snackbar("Tik tok", "Version1: 1.0");
                        },
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: controller.user['profilePic'],
                                  fit: BoxFit.contain,
                                  height: 100,
                                  width: 100,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.user['followers'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text(
                                    "Followers",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.user['followings'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text(
                                    "following",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.user['likes'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Text(
                                    "likes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (widget.uid == auth.currentUser!.uid) {
                                authController.signout();
                              } else {
                                controller.followUser();
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white60, width: 1.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(auth.currentUser!.uid == widget.uid
                                    ? "Sign out"
                                    : controller.isFollowing
                                        ? "Following"
                                        : "Follow"),
                              ),
                            ),
                          ),
                          const Divider(
                            indent: 30,
                            endIndent: 30,
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 5,
                              ),
                              itemCount: controller.user["thumbnails"].length,
                              itemBuilder: (context, index) {
                                var thumbnail =
                                    controller.user["thumbnails"][index];

                                return CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: thumbnail,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                );
                              }),
                        ],
                      ),
                    ),
                  ));
        });
  }
}
