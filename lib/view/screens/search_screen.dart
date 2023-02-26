import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controller/search_user_controller.dart';
import 'package:tiktok/view/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _searchTextController = TextEditingController();
  var searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: TextFormField(
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Search Username"),
              controller: _searchTextController,
              onFieldSubmitted: (value) {
                searchController.fetchUsers(value);
              },
            ),
          ),
          body: searchController.users.isEmpty
              ? const Center(child: Text("Search username"))
              : Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                        itemCount: searchController.users.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = searchController.users[index];
                          return ListTile(
                            onTap: () {
                              Get.to(() => ProfileScreen(uid: item.uid));
                            },
                            leading: CircleAvatar(
                              child: Image(
                                image: NetworkImage(item.profilePhoto),
                              ),
                            ),
                            title: Text(item.name),
                          );
                        })
                  ],
                ));
    });
  }
}
