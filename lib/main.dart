//  paquete package quer permite instalar los Widgets  y funcionalidades de la app
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';
import 'package:proyect_recetas_comidas/screens/home_screen.dart';
import 'package:proyect_recetas_comidas/screens/favorites_recipes.dart';

// // funcion que permite dar inicio a la app
// void main() => runApp(const MyApp());

// // clase donde se construira el h9ome de la app
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // tendremos como primera medida un contenedor
//   @override
//   Widget build(BuildContext context) {
//     //debugShowCheckedModeBanner: false, es para que no aparezca la barra de debug que sale en la parte superior derecha
//     return MultiProvider(
//       providers: [
//         // Provider para el RecipesProvider
//         ChangeNotifierProvider(create: (_) => RecipesProvider()),
//       ],
//       child: const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Hola Mundo',
//         home: RecibeBok(),
//       ),
//     );
//   }
// }

// class RecibeBok extends StatefulWidget {
//   const RecibeBok({super.key});

//   @override
//   State<RecibeBok> createState() => _RecibeBokState();
// }

// class _RecibeBokState extends State<RecibeBok> {
//   String? categoriaSeleccionada;
//   final List<String> categorias = ['Sushi', 'Todas las recetas'];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 94, 7, 145),
//           title: const Text(
//             'Libro de Recetas🍽️',
//             style: TextStyle(color: Colors.white),
//           ),
//           actions: [
//             DropdownButton<String>(
//               value: categoriaSeleccionada,
//               hint: const Text(
//                 "Selecciona una categoría",
//                 style: TextStyle(color: Colors.white),
//               ),
//               dropdownColor: const Color.fromARGB(255, 94, 7, 145),
//               iconEnabledColor: Colors.white,
//               items:
//                   categorias.map((cat) {
//                     return DropdownMenuItem<String>(
//                       value: cat,
//                       child: Text(
//                         cat[0].toUpperCase() + cat.substring(1),
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     );
//                   }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   categoriaSeleccionada = newValue;
//                 });

//                 // Aquí llamas al método del provider para filtrar
//                 Provider.of<RecipesProvider>(
//                   context,
//                   listen: false,
//                 ).FetchRecipesByCategory(newValue!);
//               },
//             ),
//           ],
//           bottom: const TabBar(
//             indicatorColor: Color.fromARGB(255, 207, 154, 6),
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.white,
//             tabs: [
//               Tab(icon: Icon(Icons.home), text: 'Home'),
//               Tab(icon: Icon(Icons.favorite), text: 'Favoritos'),
//             ],
//           ),
//         ),
//         body: const TabBarView(children: [HomeScreen(), FavoritesRecipes()]),
//       ),
//     );
//   }
// }
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

class RecibeBok extends StatefulWidget {
  const RecibeBok({super.key});

  @override
  State<RecibeBok> createState() => _RecibeBokState();
}

class _RecibeBokState extends State<RecibeBok> {
  String? categoriaSeleccionada;
  final List<String> categorias = ['Sushi','Hamburguesa', 'Todas las recetas'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(98), // altura reducida
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 94, 7, 145),
            title: const Text(
              'Recetas🍽️',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              DropdownButton<String>(
                value: categoriaSeleccionada,
                hint: const Text(
                  "Selecciona una categoría",
                  style: TextStyle(color: Colors.white),
                ),
                dropdownColor: const Color.fromARGB(255, 94, 7, 145),
                iconEnabledColor: Colors.white,
                items: categorias
                    .map((cat) {
                      return DropdownMenuItem<String>(
                        value: cat,
                        child: Text(
                          cat[0].toUpperCase() + cat.substring(1),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    })
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    categoriaSeleccionada = newValue;
                  });

                  // Aquí llamas al método del provider para filtrar
                  Provider.of<RecipesProvider>(
                    context,
                    listen: false,
                  ).FetchRecipesByCategory(newValue!);
                },
              ),
            ],
            bottom: const TabBar(
              indicatorColor: Color.fromARGB(255, 207, 154, 6),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.favorite), text: 'Favoritos'),
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [HomeScreen(), FavoritesRecipes()]),
      ),
    );
  }
}