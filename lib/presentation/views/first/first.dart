import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/core/logic/helper_methods.dart';
import 'package:recipe/presentation/views/user_auth/log_in/login.dart';
import 'package:recipe/presentation/views/user_auth/sign_up/signup.dart';

import '../../../../app/app_images.dart';
import '../../components/custom_button.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});


  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body:Stack(alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.pic), fit: BoxFit.fill)),),
             Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  const Text(
                    "Recipe",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 300,),
                  GestureDetector(
                      onTap: () {
                       navigateTo(const LogIn());
                      },
                      child:
                      CustomBottom(name: "Log in", width: 200.w, height: 50.h,color: Colors.grey,)),
                  SizedBox(height: 16.h),
                  GestureDetector(
                      onTap: () {
                       navigateTo(const SignUp());
                      },
                      child:
                      CustomBottom(name: "Sign Up", width: 200.w, height: 50.h,color: Colors.grey,)),
                ],
              ),
            ),


          ],
        )

    );


  }
}
