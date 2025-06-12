import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_recetas_comidas/models/recipe_model.dart';
import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';

// class RecipeDetail extends StatefulWidget {
//   final Recipe recipesData; // Recibimos la receta que seleccionamos
//   //constructor
//   const RecipeDetail({
//     super.key,
//     required this.recipesData,
//   }); // va a ser requerido y recibir es un RecipeDetail

//   @override
//   _RecipeDetailState createState() => _RecipeDetailState();
// }

// class _RecipeDetailState extends State<RecipeDetail>
//     with SingleTickerProviderStateMixin {
//   bool isFavorite = false; // variable para saber si es favorito o no

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     isFavorite = Provider.of<RecipesProvider>(
//       context,
//       listen: false,
//     ).favoriteRecipe.contains(widget.recipesData);
//     ; //verificamos si la receta es favorita o no
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.recipesData.name,
//           style: TextStyle(color: Colors.white), ///colo del no
//         ),
//         backgroundColor:const Color.fromARGB(255, 94, 7, 145),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           color: const Color.fromARGB(255, 165, 162, 162), //color del icono de regreso
//           onPressed: () {
//             Navigator.pop(context);
//           },

//         ),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await Provider.of<RecipesProvider>(
//                 context,
//                 listen: false,
//               ).toggleFavorite(widget.recipesData);
//               setState(() {
//                 isFavorite =
//                     !isFavorite; //cambia el estado de la variable isFavorite
//               });
//             },
//             //animacion del icono de favorito
//             // AnimatedSwitcher permite hacer una animacion al cambiar de icono
//             icon: AnimatedSwitcher(
//               duration: Duration(milliseconds: 300),
//               transitionBuilder: (child, animation) {
//                 return ScaleTransition(scale: animation, child: child);
//               },
//               child: Icon(
//                 isFavorite ? Icons.favorite : Icons.favorite_border,
//                 key: ValueKey<bool>(isFavorite),
//                 color: Colors.red, //color del corazon
//                 size: 30, //tamaño del corazon
//               ),
//             ),
//           ),
//         ], //icono que permite regresar a la pantalla anterior
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(4),
//         child: Column(
//           children: [
//             // Image.network(widget.recipesData.image), //imagen de la receta
//             SizedBox(height: 8), //espacio entre los widgets
//             Text(widget.recipesData.name), //nombre del chef
//             SizedBox(height: 8), //espacio entre los widgets
//             Text("by ${widget.recipesData.chef}"), //nombre de la receta),
//             SizedBox(height: 8), //espacio entre los widgets
//             Text('Recipes steps'),
//             for (var Step in widget.recipesData.recipes) Text("- $Step"),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RecipeDetail extends StatefulWidget {
//   final Recipe recipesData; // Recibimos la receta que seleccionamos

//   const RecipeDetail({
//     super.key,
//     required this.recipesData,
//   });

//   @override
//   _RecipeDetailState createState() => _RecipeDetailState();
// }

// class _RecipeDetailState extends State<RecipeDetail>
//     with SingleTickerProviderStateMixin {
//   bool isFavorite = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     isFavorite = Provider.of<RecipesProvider>(
//       context,
//       listen: false,
//     ).favoriteRecipe.contains(widget.recipesData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.recipesData.name,
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor:const Color.fromARGB(255, 94, 7, 145),//color barra de arriba
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           color: const Color.fromARGB(255, 165, 162, 162),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await Provider.of<RecipesProvider>(
//                 context,
//                 listen: false,
//               ).toggleFavorite(widget.recipesData);
//               setState(() {
//                 isFavorite = !isFavorite;
//               });
//             },
//             icon: AnimatedSwitcher(
//               duration: Duration(milliseconds: 300),
//               transitionBuilder: (child, animation) {
//                 return ScaleTransition(scale: animation, child: child);
//               },
//               child: Icon(
//                 isFavorite ? Icons.favorite : Icons.favorite_border,
//                 key: ValueKey<bool>(isFavorite),
//                 color: const Color.fromARGB(255, 255, 98, 77),
//                 size: 30,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: Card(
//           color: const Color.fromARGB(255, 109, 87, 148), // Color rojo claro del card
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.recipesData.name,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text("by ${widget.recipesData.chef}"),
//                 const SizedBox(height: 8),
//                 const Text('Recipe steps:'),
//                 const SizedBox(height: 4),
//                 for (var step in widget.recipesData.recipes)
//                   Text("• $step"),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class RecipeDetail extends StatefulWidget {
  final Recipe recipesData;

  const RecipeDetail({super.key, required this.recipesData});

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(
      context,
      listen: false,
    ).favoriteRecipe.contains(widget.recipesData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipesData.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 94, 7, 145),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: const Color.fromARGB(255, 165, 162, 162),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<RecipesProvider>(
                context,
                listen: false,
              ).toggleFavorite(widget.recipesData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(isFavorite),
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://t4.ftcdn.net/jpg/02/92/20/37/360_F_292203735_CSsyqyS6A4Z9Czd4Msf7qZEhoxjpzZl1.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              height: 900,
              width: 380,
              margin: const EdgeInsets.all(12),
              child: Card(
                color: Colors.white.withOpacity(0.92),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 230,
                      width: double.infinity,
                      child: Image.network(
                        widget.recipesData.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                widget.recipesData.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "by ${widget.recipesData.chef}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Ingredientes:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              ...widget.recipesData.recipes.map(
                                (step) => Text(
                                  "• $step",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}