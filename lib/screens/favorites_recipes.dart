import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';
import 'package:proyect_recetas_comidas/screens/recipe_detail.dart';

class FavoritesRecipes extends StatelessWidget{
  const FavoritesRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (context, recipeProvider, child) {
         final favoritesRecipes = recipeProvider.favoriteRecipe;

         return favoritesRecipes.isEmpty ? 
          Center(child: Text("No hay recetas favoritas"),) 
          : ListView.builder(
            itemCount: favoritesRecipes.length, // numero de recetas favoritas  
            itemBuilder: (context, index){
              final recipe = favoritesRecipes[index]; // Obtiene la receta favorita
              favoriteRecipesCard(recipe: favoritesRecipes[index]); // Muestra la receta favorita
            }
          );
        },  
      ),
    );
  }
}

//card de recetas favoritas
class favoriteRecipesCard extends StatelessWidget {
  final recipe; // Variable to hold the recipe data
  const favoriteRecipesCard({super.key,required this.recipe}); // Constructor to initialize the recipe variable

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetail(recipesData: recipe)));  // Navigate to the recipe details page
      },
        child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(recipe.name), // Display the recipe name
            Text(recipe.chef), // Display the recipe name
            
          ],
        ),
        ),
      );
  }
}
