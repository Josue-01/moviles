import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget{
  // esto es lo que recibiremos del home
  final String recipeName;
  //constructor
const RecipeDetail({super.key, required this.recipeName}); // va a ser requerido y recibir es un RecipeDetail

  @override
  Widget build(BuildContext context) {
    //Scaffold hoja en blanco
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), color: Colors.blueGrey, 
        onPressed: () {Navigator.pop(context);},) ,//icono que permite regresar a la pantalla anterior
        ),
    );
  }
}

