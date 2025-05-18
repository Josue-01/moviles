//  paquete package quer permite instalar los Widgets  y funcionalidades de la app
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';
import 'package:proyect_recetas_comidas/screens/home_screen.dart';
import  'package:proyect_recetas_comidas/screens/favorites_recipes.dart';

// funcion que permite dar inicio a la app
void main() => runApp(const MyApp());

// clase donde se construira el h9ome de la app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // tendremos como primera medida un contenedor
  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner: false, es para que no aparezca la barra de debug que sale en la parte superior derecha
    return MultiProvider(
      providers: [
        // Provider para el RecipesProvider
        ChangeNotifierProvider(create: (_) => RecipesProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hola Mundo',
        home: RecibeBok(),
      ),
    );
  }
}

// StatelessWidget indica que su estado sera totalmente dinamico no se podra modificar
// StatelessWidget es un widget que no tiene estado, es decir, no cambia su aspecto en función de los datos que recibe.
class RecibeBok extends StatelessWidget {
  const RecibeBok({super.key});

  ///el override  sera el constructor de la clase
  ///El widget Scaffold es como si fuera una hoja de libro totalmente en blanco
  ///para agregar un hijo en cada widget tiene una palabra en especifico child o en dado caso que se puedan
  ///agregar varios hijos se usa children
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 21, 7, 145),
          title: Text(
            'Comidas tipicas de Tiquicia🍽️',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs:[
            Tab(icon: Icon(Icons.home), text: 'Home',),
            Tab(icon: Icon(Icons.favorite), text: 'Favoritos',)
            // Tab(icon: Icon(Icons.settings), text: 'Ajustes',)
          ]),
        ), 
        ///TabBarView permitira navergar dependiendo de las tabs que tengamos
        body: const TabBarView(children: [
          HomeScreen(),FavoritesRecipes() ])),
    );
  }
}

