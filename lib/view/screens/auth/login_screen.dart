import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok/controller/auth_controller.dart';
import 'package:tiktok/view/screens/auth/sign_up.dart';
import 'package:tiktok/view/widgets/text_input.dart';
import '../../widgets/glitch_effect.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            GlithEffect(
              child: const Text("TikTok",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30)),
            ),

            //email
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputFiled(
                controller: _emailController,
                myLabelText: "email",
                myIcon: Icons.email,
              ),
            ),

            //password
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputFiled(
                controller: _passwordController,
                myLabelText: "password",
                myIcon: Icons.lock,
                toHide: true,
              ),
            ),

            //login button
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                AuthController.instance.login("dem@dem.com", "123456");
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: const Text("Login"),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [InkWell(
                    onTap: (){
                      Get.to(SignUpScreen());
                    },
                    child: Text("Sign up"))]),
          ],
        ),
      ),
    );
  }
}
