import 'package:flutter/material.dart';
import 'package:tiktok/Constants.dart';

import '../widgets/customAddIcon.dart';
class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed ,
        currentIndex: pageIndex,
        onTap: (index){
          setState(() {
            pageIndex=index;
          });
        },
        items:  const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
            label: 'Search'
          ),
          BottomNavigationBarItem(
              icon: customAddIcon(),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'message'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile'
          )
        ],
      ),

      body: Center(
        child: pageIndices[pageIndex],
      ),
    );
  }
}
