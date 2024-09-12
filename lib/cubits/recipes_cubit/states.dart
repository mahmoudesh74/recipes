import '../../core/models/add_recipe_model/model.dart';

class RecipesState{}
class GetRecipeSuccessState extends RecipesState{
  final List<AddNewRecipe> recipes;

  GetRecipeSuccessState({required this.recipes});
}
class GetRecipeFailureState extends RecipesState{}
class GetRecipeLoadingState extends RecipesState{}