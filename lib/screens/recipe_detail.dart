import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_recetas_comidas/models/recipe_model.dart';
import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipesData; // Recibimos la receta que seleccionamos
  //constructor
  const RecipeDetail({
    super.key,
    required this.recipesData,
  }); // va a ser requerido y recibir es un RecipeDetail

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  bool isFavorite = false; // variable para saber si es favorito o no

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(
      context,
      listen: false,
    ).favoriteRecipe.contains(widget.recipesData);
    ; //verificamos si la receta es favorita o no
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipesData.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.blueGrey,
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
                isFavorite =
                    !isFavorite; //cambia el estado de la variable isFavorite
              });
            },
            //animacion del icono de favorito
            // AnimatedSwitcher permite hacer una animacion al cambiar de icono
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(isFavorite),
                color: Colors.red,
              ),
            ),
          ),
        ], //icono que permite regresar a la pantalla anterior
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Image.network(widget.recipesData.image), //imagen de la receta
            Text(widget.recipesData.name), //nombre del chef
            SizedBox(height: 8), //espacio entre los widgets
            Text("by ${widget.recipesData.chef}"), //nombre de la receta),
            SizedBox(height: 8), //espacio entre los widgets
            Text('Recipes steps'),
            for (var Step in widget.recipesData.recipeSteps) Text("- $Step"),
          ],
        ),
      ),
    );
  }
}
