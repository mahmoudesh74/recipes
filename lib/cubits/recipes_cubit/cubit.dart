import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/models/add_recipe_model/model.dart';

import 'states.dart';

class RecipeCubit extends Cubit<RecipesState> {
  RecipeCubit() : super(RecipesState());

  List<AddNewRecipe> recipes = [];
  String? imgPath;
  final nameController = TextEditingController();
  final ingredientsController = TextEditingController();
  final instructionsController = TextEditingController();
  void addRecipe(AddNewRecipe recipe) {
    recipes.add(recipe);

    emit(GetRecipeSuccessState(recipes: recipes));
  }
}
