import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/view/widgets/text_input.dart';

import '../../Constants.dart';
import '../../controller/comment_controller.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class CommentScreen extends StatelessWidget {
  final String id;

  CommentScreen({Key? key, required this.id}) : super(key: key);

  final _commentTextController = TextEditingController();
  var commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(comment.profilePic),
                          ),
                          title: Row(
                            children: [
                              Text(
                                comment.username,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                comment.comment,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                timeAgo.format(comment.datePub.toDate()),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${comment.likes.length.toString()} likes',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () {
                                commentController.likeComment(comment.id);
                              },
                              child: Icon(Icons.favorite,
                              color:comment.likes.contains(auth.currentUser!.uid) ?Colors.redAccent:Colors.white,)),
                        );
                      });
                }),
              ),
              Divider(),
              ListTile(
                title: TextInputFiled(
                  controller: _commentTextController,
                  myLabelText: 'Comments',
                  myIcon: Icons.comment,
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(_commentTextController.text);
                    _commentTextController.text = "";
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text("Send"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
