import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/presentation/views/user_auth/firebase_auth/firebase_auth.dart';

import '../../../components/custom_button.dart';
import '../log_in/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
final  FirebaseAuthService auth=FirebaseAuthService();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  void
    dispose(){
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

  @override

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  late bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Form(

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(child: Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Text("Recipe",style: TextStyle(color:Colors.green,fontSize: 30,fontWeight: FontWeight.bold),),
                    )),
                    SizedBox(height: 50.h,),

                    TextFormField(

                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Email not exist");
                        } else if (value.length < 3) {
                          return "Email 3 letter ata least ";
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
                    SizedBox(height: 30.h),
                    TextFormField(
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
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
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

                    SizedBox(height: 30.h),
                    InkWell(
                         onTap: signUp,

                        child: CustomBottom(name: "Sign Up", width: 130.w, height: 50.h)
                    )

                  ],
                ),
              ),
            ),
          ),)
    );
  }




  void signUp()async{
    String email=emailController.text;
    String password=passwordController.text;


    User? user=await auth.signUpWithEmailAndPassword(email, password);

    print("user is successfully created");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) =>  const LogIn()));
    }
}



