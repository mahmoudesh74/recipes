import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

final formKey = GlobalKey<FormState>();

class _AddRecipeState extends State<AddRecipe> {
  String? imgPath;
  final nameController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              " Recipe Form",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      CollectionReference collRef = FirebaseFirestore.instance
                          .collection('recipes');

                      collRef.add({

                        'name': nameController.text,
                        'ingredients': ingredientsController.text,
                        'instructions': instructionsController.text,
                        'imgPath': imgPath,
                        'userId': userId,

                      });


                     }
                  },
                  child: const Icon(Icons.check, size: 28)),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 32),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Name not exist");
                    } else {
                      return null;
                    }
                  },
                  cursorColor: Colors.green,
                  maxLines: 1,


                  decoration: const InputDecoration(
                    hintText: "Recipe Name",
                    hintStyle: TextStyle(
                      color: Color(0xff62FCD7),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ingredientsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Ingredients not exist");
                    } else {
                      return null;
                    }
                  },

                  cursorColor: Colors.green,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    hintText: "Ingredients",
                    hintStyle: TextStyle(color: Color(0xff62FCD7)),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: instructionsController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Instructions not exist");
                    } else {
                      return null;
                    }
                  },
                  cursorColor: Colors.green,
                  maxLines: 7,
                  decoration: const InputDecoration(
                    hintText: "Instructions",
                    hintStyle: TextStyle(color: Color(0xff62FCD7)),
                  ),
                ),
                SizedBox(height: 30.h),
                if (imgPath != null)
                  Image.file(File(imgPath!), width: 200, height: 200),
                GestureDetector(
                  onTap: () async {
                    XFile? file = await ImagePicker.platform
                        .getImageFromSource(source: ImageSource.gallery);

                    if (file != null) {
                      imgPath = file.path;
                      setState(() {});
                    }
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(top: 16.h),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20.r)),
                    width: 150.w,
                    height: 50.h,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Add Photo",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: Colors.white),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }

}
