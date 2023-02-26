import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tiktok/controller/auth_controller.dart';
import 'package:tiktok/view/widgets/text_input.dart';

import '../../widgets/glitch_effect.dart';

class SignUpScreen extends StatelessWidget {

  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _setpasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 70),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // title
              const SizedBox(
                height: 20,
              ),
              GlithEffect(
                child: const Text("Welcome to TikTok",
                    style:TextStyle(fontWeight: FontWeight.w900,
                        fontSize: 30)
                ),
              ),

              //profile avatar
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: (){
                  AuthController.instance.pickImage();
                },
                child: Stack(
                  children:  [
                    const CircleAvatar(
                     backgroundImage:NetworkImage("https://t3.ftcdn.net/jpg/02/09/37/00/360_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR.jpg"),
                      radius: 60,
                    ),
                    Positioned(
                        bottom: 0,
                    right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                          ),
                            child: const Icon(Icons.edit,size: 20,color: Colors.black,)
                        ),
                    )
                  ],
                ),
              ),



              //username
               const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputFiled(
                  controller: _usernameController,
                  myLabelText: "Username",
                  myIcon: Icons.person,
                ),
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
                  controller: _setpasswordController,
                  myLabelText: "Set password",
                  myIcon: Icons.lock,
                  toHide: true,
                ),
              ),

              // confirm password
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputFiled(
                  controller: _confirmpasswordController,
                  myLabelText: "Confirm password",
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
                  AuthController.instance.SignUp(_usernameController.text, _emailController.text,_setpasswordController.text, AuthController.instance.proImage);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  child: const Text("Sign up"),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [InkWell(
                      onTap: (){
                        Get.to(SignUpScreen());
                      },
                      child: Text("Login"))]),

            ],
          ),
        ),
      ),
    );
  }
}
