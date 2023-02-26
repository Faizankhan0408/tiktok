import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/Constants.dart';
import 'package:tiktok/controller/auth_controller.dart';
import 'package:tiktok/view/screens/auth/login_screen.dart';
import 'package:tiktok/view/screens/auth/sign_up.dart';
import 'package:tiktok/view/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      home:LoginScreen() ,
    );
  }
}


