import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/core/models/add_recipe_model/model.dart';
import 'package:recipe/cubits/recipes_cubit/cubit.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

final formKey = GlobalKey<FormState>();

class _AddRecipeState extends State<AddRecipe> {
  late RecipeCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeCubit(),
      child: Scaffold(
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
                child: InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        CollectionReference collRef = FirebaseFirestore.instance.collection('recipes');
                        collRef.add({
                          'name':cubit.nameController.text,
                          'ingredients':cubit.ingredientsController.text,
                          'instructions':cubit.instructionsController.text,
                          'imgPath':cubit.imgPath,
                        });

                        BlocProvider.of<RecipeCubit>(context).addRecipe(
                            AddNewRecipe(
                                imgPath: cubit.imgPath ?? "",
                                name: cubit.nameController.text,
                                ingredients: cubit.ingredientsController.text,
                                instructions:
                                    cubit.instructionsController.text));
                        Navigator.pop(context);
                        setState(() {});
                      }
                      print(
                          BlocProvider.of<RecipeCubit>(context).recipes.length);
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
                    controller: cubit.nameController,
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
                    controller: cubit.ingredientsController,
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
                    controller: cubit.instructionsController,
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
                  if (cubit.imgPath != null)
                    Image.file(File(cubit.imgPath!), width: 200, height: 200),
                  GestureDetector(
                    onTap: () async {
                      XFile? file = await ImagePicker.platform
                          .getImageFromSource(source: ImageSource.gallery);

                      if (file != null) {
                        cubit.imgPath = file.path;
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
          )),
    );
  }

  @override
  void dispose() {
    cubit.nameController.clear();
    cubit.instructionsController.clear();
    cubit.ingredientsController.clear();
    super.dispose();
  }
}
