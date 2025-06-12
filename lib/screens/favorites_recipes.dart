// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';
import 'package:proyect_recetas_comidas/screens/recipe_detail.dart';

// class FavoritesRecipes extends StatelessWidget {
//   const FavoritesRecipes({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer<RecipesProvider>(
//         builder: (context, recipeProvider, child) {
//           final favoritesRecipes = recipeProvider.favoriteRecipe;

//           return favoritesRecipes.isEmpty
//               ? Center(child: Text("No hay recetas favoritas"))
//               : ListView.builder(
//                 itemCount:
//                     favoritesRecipes.length, // numero de recetas favoritas
//                 itemBuilder: (context, index) {
//                   final recipe =
//                       favoritesRecipes[index]; // O btiene la receta favorita
//                   return favoriteRecipesCard(
//                     recipe: favoritesRecipes[index],
//                   ); // Muestra la receta favorita
//                 },
//               );
//         },
//       ),
//     );
//   }
// }

// //card de recetas favoritas
// class favoriteRecipesCard extends StatelessWidget {
//   final recipe; // Variable to hold the recipe data
//   const favoriteRecipesCard({
//     super.key,
//     required this.recipe,
//   }); // Constructor to initialize the recipe variable

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => RecipeDetail(recipesData: recipe),
//           ),
//         ); // Navigate to the recipe details page
//       },
//       child: Card(
//         color: const Color.fromARGB(255, 94, 7, 145),
//         child: Column(
//           children: [
//             Text(
//               recipe.name,
//               style: TextStyle(color: Colors.white),
//             ), // Display the recipe name
//             Text(
//               recipe.chef,
//               style: TextStyle(color: Colors.white),
//             ), // Display the recipe name
//           ],
//         ),
//       ),
//     );
//   }
// }
class FavoritesRecipes extends StatelessWidget {
  const FavoritesRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          SizedBox.expand(
            child: Image.network(
              'https://t4.ftcdn.net/jpg/02/92/20/37/360_F_292203735_CSsyqyS6A4Z9Czd4Msf7qZEhoxjpzZl1.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Contenido de recetas favoritas
          Consumer<RecipesProvider>(
            builder: (context, recipeProvider, child) {
              final favoritesRecipes = recipeProvider.favoriteRecipe;

              if (favoritesRecipes.isEmpty) {
                return const Center(
                  child: Text(
                    "No hay recetas favoritas",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: favoritesRecipes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,       // 2 recetas por fila
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 250,     // altura fija para cada tarjeta
                  ),
                  itemBuilder: (context, index) {
                    final recipe = favoritesRecipes[index];
                    return favoriteRecipesCard(recipe: recipe);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Card de recetas favoritas con imagen
class favoriteRecipesCard extends StatelessWidget {
  final recipe;

  const favoriteRecipesCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(recipesData: recipe),
          ),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 237, 236, 238),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                recipe.image,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 140,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    recipe.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'By ${recipe.chef}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.purple, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}