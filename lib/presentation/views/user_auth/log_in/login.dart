import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/app/app_images.dart';
import 'package:recipe/core/logic/helper_methods.dart';
import 'package:recipe/presentation/components/custom_button.dart';
import 'package:recipe/presentation/views/home/view.dart';

import '../firebase_auth/firebase_auth.dart';
import '../sign_up/signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}


class _LogInState extends State<LogIn> {
  final formKey = GlobalKey<FormState>();

  final FirebaseAuthService auth = FirebaseAuthService();
  TextEditingController emailController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  late bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric( vertical: 30.h),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  "Recipe",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              )),

              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(AppImages.pic2,width: double.infinity,height: 250,),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Email not exist");
                    } else if (value.length < 3) {
                      return "Email 3 letter at least ";
                    }
                    return null;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Email",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(height:16.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("password not exist ");
                    } else if (value.length < 8) {
                      return " password 8 letters ata least";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _toggle,
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      signIn();
                    }
                  },
                  child:
                      CustomBottom(name: "Log in", width: 350.w, height: 50.h)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Did’t have any account?',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      navigateTo(const SignUp());
                    },
                    child: Text('Sign Up here',
                        style: TextStyle(
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("user is successfully sign in");
      navigateTo(const HomePage(), removeHistory: true);
    } else {
      print("some error occurred");
    }
  }
}
