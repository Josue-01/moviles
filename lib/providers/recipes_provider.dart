import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyect_recetas_comidas/models/recipe_model.dart';
import 'package:http/http.dart' as http; //paquete para hacer peticiones http

class RecipesProvider extends ChangeNotifier {
  //variable de carga
  bool isLoading = false; // va a indicar si la carga es verdadera o falsa
  List<Recipe> recipes = [];
  List<Recipe> favoriteRecipe = [];

  Future<void> FetchRecipes() async {
    //var carga`1
    isLoading = true;
    //  notifyListeners(); //notifica a los widgets que dependen de este provider que el estado ha cambiado4

    final url = Uri.parse('http://localhost:12346/recipes');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(
          response.body,
        ); //lo que responda el response lo vamos acastear en un JSON
        recipes = List<Recipe>.from(
          data['recipes'].map((recipe) => Recipe.fromJson(recipe)),
        );
      } else {
        print('Error: ${response.statusCode}');
        //en caso de que no se pueda conectar a la api
        recipes =
            []; //como tenemos el caso de una lista vacia entonces retornamos una lista vacia
      }
    } catch (e) {
      //indicar error en nuestra llamada
      print('Error en la respuesta');
      recipes = []; //retornamos la lista de recetas vacia
    } finally {
      isLoading = false; //carga en falso
      notifyListeners(); //notifica a los widgets que dependen de este provider que el estado ha cambiado
    }
  }

  //funcion para agregar y eliminar favoritos
  Future<void> toggleFavorite(Recipe recipe) async {
    final isFavorite = favoriteRecipe.contains(recipe);

    try {
      final url = Uri.parse('http://localhost:12346/favorites');
      final response =
          isFavorite
              ? await http.delete(url, body: json.encode({"id": recipe.id}))
              : await http.post(url, body: json.encode(recipe.toJson()));
      ; //eliminar receta de favoritos
      if (response.statusCode == 200) {
        if (isFavorite) {
          favoriteRecipe.remove(recipe); //eliminar receta de favoritos
        } else {
          favoriteRecipe.add(recipe); //agregar receta a favoritos
        }
        notifyListeners();
      } else {
        throw Exception(
          'Error al agregar o eliminar favorito: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error al agregar o eliminar favorito: $e');
    } finally {
      notifyListeners(); // notifica a los widgets que dependen de este provider que el estado ha cambiado
    }
  }

  // Categorias
  Future<void> FetchRecipesByCategory(String category) async {
    isLoading = true;
    notifyListeners(); // notifica a los widgets que dependen de este provider que el estado ha cambiado

    final url = Uri.parse('http://localhost:12346/recipes?category=$category');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipes = List<Recipe>.from(
          data['recipes'].map((recipe) => Recipe.fromJson(recipe)),
        );
      } else {
        print('Error: ${response.statusCode}');
        recipes = []; // Retorna una lista vacía en caso de error
      }
    } catch (e) {
      print('Error en la respuesta: $e');
      recipes = []; // Retorna una lista vacía en caso de error
    } finally {
      isLoading = false; // Carga en falso
      notifyListeners(); // Notifica a los widgets que dependen de este provider que el estado ha cambiado
    }
  }
}
