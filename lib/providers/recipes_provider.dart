 import 'dart:convert';
 import 'package:flutter/material.dart';
 import 'package:proyect_recetas_comidas/models/recipe_model.dart';
 import 'package:http/http.dart' as http; //paquete para hacer peticiones http

 class RecipesProvider extends ChangeNotifier{
   //variable de carga
   bool isLoading = false;// va a indicar si la carga es verdadera o falsa
   List<Recipe> recipes = [];

    Future<void> FetchRecipes() async{
     //var carga
     isLoading = true;
     notifyListeners(); //notifica a los widgets que dependen de este provider que el estado ha cambiado

     final url =  Uri.parse('http://10.0.2.2:12346/recipes');
   try{
       final response = await http.get(url);
       if (response.statusCode == 200){
      final data = jsonDecode(response.body); //lo que responda el response lo vamos acastear en un JSON
       recipes = List<Recipe>.from(data['recipes'].map((recipe) => Recipe.fromJson(recipe)));
     } else {
      print('Error: ${response.statusCode}');
     //en caso de que no se pueda conectar a la api
     recipes = [];//como tenemos el caso de una lista vacia entonces retornamos una lista vacia
    }
   } catch(e){ 
     //indicar error en nuestra llamada
      print('Error en la respuesta');
      recipes = []; //retornamos la lista de recetas vacia
   } finally{
     isLoading = false; //carga en falso
     notifyListeners(); //notifica a los widgets que dependen de este provider que el estado ha cambiado
    }

  }
}
