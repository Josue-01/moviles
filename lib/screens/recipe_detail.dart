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
      context,listen: false,)
      .favoriteRecipe
      .contains(widget.recipesData);
      ; //verificamos si la receta es favorita o no
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.recipesData.name),
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
            onPressed: ()async{
              await Provider.of<RecipesProvider>(context, listen: false).toggleFavorite(widget.recipesData);
              setState(() {
                isFavorite = !isFavorite; //cambia el estado de la variable isFavorite
              });
            }, 
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),),
        ],//icono que permite regresar a la pantalla anterior
      ),
    );
  }
}

