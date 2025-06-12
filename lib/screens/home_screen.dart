import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';
import 'package:proyect_recetas_comidas/screens/recipe_detail.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final recipesProvider = Provider.of<RecipesProvider>(context);
//     final recipesProvider = Provider.of<RecipesProvider>(
//       context,
//       listen: false,
//     );
//     recipesProvider.FetchRecipes(); //llamamos a la funcion para que se ejecute al iniciar la app

//     return Scaffold(
//       body: Consumer<RecipesProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             ); //si no carga el dato que apareza un circulo de carga
//           } else if (provider.recipes.isEmpty) {
//             //en el caso de que llegue vacio, y preguntamos si esta llegando al snapchot
//             return const Center(child: Text('No se encontraron recetas'));
//           } else {
//             return ListView.builder(
//               itemCount:
//                   provider
//                       .recipes
//                       .length, //para contar cuantos objetos o recetas tiene dentro del listado
//               itemBuilder: (context, index) {
//                 return _RecipesCard(context, provider.recipes[index]);
//               },
//             );
//           }
//         },
//       ),
//       //FloatingActionButton recibira un widget de
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.orange,
//         child: Icon(Icons.add, color: Colors.white),
//         //onPressed es para que cuando se presione el boton haga algo
//         onPressed: () {
//           _showBottom(context);
//         },
//       ), //FloatingActionButton
//     );
//   }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(
      context,
      listen: false,
    );
    recipesProvider.FetchRecipes();

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

          // Contenido de recetas
          Consumer<RecipesProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.recipes.isEmpty) {
                return const Center(
                  child: Text(
                    'No se encontraron recetas',
                    style: TextStyle(color: Colors.white), // Color blanco para que sea visible
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: provider.recipes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 1 receta por fila
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      mainAxisExtent: 200,
                    ),
                    itemBuilder: (context, index) {
                      return _RecipeCard(context, provider.recipes[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showBottom(context);
        },
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        color: Colors.white,
        child: RecipeForm(),
      ),
    );
  }

  Widget _RecipeCard(BuildContext context, dynamic recipe) {
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
        color: const Color.fromARGB(255, 236, 235, 236),//color de la tarjeta
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                recipe.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 140,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1),
              child: Column(
                children: [
                  Text(
                    recipe.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'By ${recipe.chef}',
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 12,
                    ),
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

// formulario, para creer una receta
class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});
  @override
  Widget build(BuildContext context) {
    //la llamammos para que se pueda almacenar los valores de los campos
    final _formKey =
        GlobalKey<
          FormState
        >(); //FormState  para que sepa que va  guardar el estado del formulario
    //key esta propiedad y su valor permiite a loq eu seria el valor y obtener toda la info de los campos

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++controladores

    //ya viene con la funcionaldad integrada que lo que agregamos sera guardado en nuestro estado
    final TextEditingController _nombreDeLaReceta = TextEditingController();
    final TextEditingController _DescripcionDeLaReceta =
        TextEditingController();
    final TextEditingController _chef = TextEditingController();
    final TextEditingController _imagenDeLareceta = TextEditingController();

    //1 primero se delcara.
    //2 Se agrega a los campos de texto.
    //3 Se declara el widget

    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++controladores

    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey, //k inicie verticalmente
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🥗Agrega una nueva receta🥗',
              style: TextStyle(color: const Color.fromARGB(255, 207, 154, 6), fontSize: 24),
            ),
            //height porque estamos usando columnas
            //*************************************Nombre de la receta****************************************************** */
            SizedBox(height: 16),
            _buildTetextField(
              //hay que agregar el validato al Widget personalizado
              controler: _nombreDeLaReceta,
              label: 'Nombre de la receta',
              validator: (value) {
                //validar que el campo no este vacio
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            //*************************************Descripcion de la receta****************************************************** */
            SizedBox(height: 16),
            _buildTetextField(
              maxLines: 2,
              controler: _DescripcionDeLaReceta,
              label: 'Descripcion de la receta',
              validator: (value) {
                //validar que el campo no este vacio
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el Autor';
                }
                return null;
              },
            ),
            //*************************************Chef****************************************************** */
            SizedBox(height: 16),
            _buildTetextField(
              controler: _chef,
              label: 'Chef',
              validator: (value) {
                //validar que el campo no este vacio
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el Chef';
                }
                return null;
              },
            ),

            //*************************************Imagen de la receta****************************************************** */
            SizedBox(height: 16),
            _buildTetextField(
              controler: _imagenDeLareceta,
              label: 'Imagen de la receta',
              validator: (value) {
                //validar que el campo no este vacio
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la imagen';
                }
                return null;
              },
            ),
            //boton para enviar el formulario************
            SizedBox(height: 16),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // cuando eso sea cierto cerramos el formulario
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color.fromARGB(255, 94, 7, 145),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ), //Estilos al boton
                child: Text(
                  'Save Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ), //decoracion del TITULO DEL boton
            ),
          ],
        ),
      ),
    );
  }

  //*******************************************WIDGET PERSONALIZADA */

  Widget _buildTetextField({
    required String label,
    required TextEditingController controler,
    required String? Function(String?) validator,
    int maxLines = 1, //esto es algo opcional no requerido como los otros
  }) {
    return TextFormField(
      //decorar el input
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: 'Quicksand', color: Colors.black),
        //OutlineInputBorder, indica que estamos personalizando el borde de nuestro campo
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //estilo para que cada vez que seleccionemos el campo nuestro label pase a ser parte de nuestos border
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator, //validador
      maxLines: maxLines, //maximos de lineas
    );
  }
}
