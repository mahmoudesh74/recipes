import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/app/app_images.dart';
import 'package:recipe/core/logic/helper_methods.dart';
import 'package:recipe/cubits/recipes_cubit/cubit.dart';
import 'package:recipe/cubits/recipes_cubit/states.dart';
import 'package:recipe/presentation/components/custom_button.dart';
import 'package:recipe/presentation/views/add_recipe/view.dart';
import 'package:recipe/presentation/views/user_auth/log_in/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: FloatingActionButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            navigateTo(LogIn(), removeHistory: true);
          },
          child: Icon(Icons.logout_sharp),
        ),
      ),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            "Recipes",
            style: TextStyle(
                color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('recipes').snapshots(),
            builder: (context, snapshot) {
              List<Container> recipesWidget = [];
              if (snapshot.hasData) {
                final recipes = snapshot.data?.docs.reversed.toList();
                for (var recipe in recipes!) {
                  final imgPath = recipe.data().containsKey('imgPath') ? recipe['imgPath'] : null;
                  final recipeWidget = Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      recipe['name'],
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recipe['ingredients'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recipe['instructions'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (imgPath != null && imgPath.isNotEmpty)
                                SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Image.file(
                                    File(imgPath),
                                    width: 100,
                                    height: 200,
                                  ),
                                ),
                            ],
                          )
                        ],
                      ));
                  recipesWidget.add(recipeWidget);
                }
              }
              return Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                children: recipesWidget,
              ));
            },
          ),
          GestureDetector(
              onTap: () {
                navigateTo(const AddRecipe());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: CustomBottom(
                    name: "Add a Recipe", width: 150.w, height: 50.h),
              ))
        ],
      ),
    );
  }
}
