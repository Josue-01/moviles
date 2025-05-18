import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';
import 'package:proyect_recetas_comidas/screens/recipe_detail.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final recipesProvider = Provider.of <RecipesProvider>(context, listen: false);
        recipesProvider.FetchRecipes(); //llamamos a la funcion para que se ejecute al iniciar la app

    return Scaffold(
      body: Consumer<RecipesProvider>( 
      builder: (context, provider, child ){
        if (provider.isLoading){
          return const Center(child: CircularProgressIndicator(),);//si no carga el dato que apareza un circulo de carga
        }
        else if (provider.recipes.isEmpty) {//en el caso de que llegue vacio, y preguntamos si esta llegando al snapchot
          return const Center(child: Text('No se encontraron recetas'),);
        } else{
          return ListView.builder(
          itemCount: provider.recipes.length ,//para contar cuantos objetos o recetas tiene dentro del listado
          itemBuilder: (context, index){
            return _RecipesCard(context, provider.recipes[index]);
          });
        }
      }
    ), 
      //FloatingActionButton recibira un widget de
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add, color: Colors.white),
        //onPressed es para que cuando se presione el boton haga algo
        onPressed: () {
          _showBottom(context);
        },
      ), //FloatingActionButton
    );
  }

  //bottom +
  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            width:
                MediaQuery.of(context)
                    .size
                    .width, //esto es para que el contenedor se ajuste al tamaño de la pantalla
            height: 500,
            color: Colors.white,
            //para que se vea el form dentro de la pantalla, c toma el nombre de la clase y lo agregamos dentro del modal
            child: RecipeForm(),
          ),
    );
  }

  // BuildContext esta ayuda a tener la herencia de la aplicacion
  //esto es una tarjeta
  Widget _RecipesCard(BuildContext context,
  //para que el cart reciba las recetas
  dynamic recipe) {
    return GestureDetector(//SE AGREGGO EL WIDGET PARA AGREGAR EL ONTAP EL CUAL VA A REDIRIGIR A LA PANTALLA DE DETALLE
      onTap:(){
        //Navigator.push abre una nueva pantalla
        Navigator.push(context,MaterialPageRoute(builder: (context) => RecipeDetail(recipesData: recipe)));
      } ,
      child: Padding(
        //el pading con el all aplica en todos lados, pero cuando se quiere aplicar en un solo lado se usa el only()
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    //network es para traer una imagen de internet
                    //box fit es para que la imagen se ajuste al contenedor
                    child: Image.network(
                      recipe.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 26),
                Column(
                  //organizarlas para que lo que esta en el widget se vea en el centro
                  mainAxisAlignment: MainAxisAlignment.center,
                  //organizarlas para que lo que esta horizontal desde el inicio
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipe.name,
                      style: TextStyle(fontSize: 20, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 4),
                    //aqui la linea se pone en el centro de los dos
                    Container(height: 2, width: 75, color: Colors.orange),
                    Text(
                      'By ${recipe.chef}',
                      style: const TextStyle(fontSize: 20, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
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
              style: TextStyle(color: Colors.blueAccent, fontSize: 24),
            ),
            //height porque estamos usando columnas
//*************************************Nombre de la receta****************************************************** */
            SizedBox(height: 16),
            _buildTetextField(//hay que agregar el validato al Widget personalizado
              controler: _nombreDeLaReceta,
              label: 'Nombre de la receta',
              validator: (value   ) {   //validar que el campo no este vacio
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              }
            ), 
//*************************************Descripcion de la receta****************************************************** */
            SizedBox(height: 16),
            _buildTetextField(
              maxLines: 2,
              controler: _DescripcionDeLaReceta,
              label: 'Descripcion de la receta',
               validator: (value   ) {   //validar que el campo no este vacio
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el Autor';
                }
                return null;
              }
            ),
//*************************************Chef****************************************************** */
            SizedBox(height: 16),
            _buildTetextField(controler: _chef, label: 'Chef',
               validator: (value   ) {   //validar que el campo no este vacio
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el Chef';
                }
                return null;
              }),

//*************************************Imagen de la receta****************************************************** */
            SizedBox(height: 16),
            _buildTetextField(
              controler: _imagenDeLareceta,
              label: 'Imagen de la receta',
               validator: (value   ) {   //validar que el campo no este vacio
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la imagen';
                }
                return null;
              }
              ),
              //boton para enviar el formulario************
            SizedBox(
              height: 16,
            ),
  
            Center(
              child: ElevatedButton(
              onPressed: (){
              if (_formKey.currentState!.validate()){
              // cuando eso sea cierto cerramos el formulario
                Navigator.pop(context);
              }
              },
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                 shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                 )
               ), //Estilos al boton
              child: Text('Save Recipe', style: TextStyle(color: Colors.white ,
               fontSize:16, fontWeight: FontWeight.bold),) ),//decoracion del TITULO DEL boton
            )
          ],
        ),
      ),
    );
  }

//*******************************************WIDGET PERSONALIZADA */

  Widget _buildTetextField({
    required String label,
    required TextEditingController controler,
    required String? Function(String?) validator, int maxLines = 1//esto es algo opcional no requerido como los otros
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
          borderRadius: BorderRadius.circular(10))),
      validator:validator,//validador 
      maxLines: maxLines,//maximos de lineas 
    );
  }
}



/////////////////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:proyect_recetas_comidas/providers/recipes_provider.dart';
// import 'package:proyect_recetas_comidas/screens/recipe_detail.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {

//   @override
//   void initState() {
//     super.initState();
//     // Llamamos FetchRecipes una sola vez cuando se crea el widget
//     final recipesProvider = Provider.of<RecipesProvider>(context, listen: false);
//     recipesProvider.FetchRecipes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<RecipesProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (provider.recipes.isEmpty) {
//             return const Center(child: Text('No se encontraron recetas'));
//           } else {
//             return ListView.builder(
//               itemCount: provider.recipes.length,
//               itemBuilder: (context, index) {
//                 return _RecipesCard(context, provider.recipes[index]);
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.orange,
//         child: const Icon(Icons.add, color: Colors.white),
//         onPressed: () => _showBottom(context),
//       ),
//     );
//   }

//   Future<void> _showBottom(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       builder: (context) => Container(
//         width: MediaQuery.of(context).size.width,
//         height: 500,
//         color: Colors.white,
//         child: const RecipeForm(),
//       ),
//     );
//   }

//   Widget _RecipesCard(BuildContext context, dynamic recipe) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => RecipeDetail(recipesData: recipe)),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: 125,
//           child: Card(
//             child: Row(
//               children: <Widget>[
//                 Container(
//                   height: 125,
//                   width: 100,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       recipe.image,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 26),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       recipe.name,
//                       style: const TextStyle(fontSize: 20, fontFamily: 'Quicksand'),
//                     ),
//                     const SizedBox(height: 4),
//                     Container(height: 2, width: 75, color: Colors.orange),
//                     Text(
//                       'By ${recipe.chef}',
//                       style: const TextStyle(fontSize: 20, fontFamily: 'Quicksand'),
//                     ),
//                     const SizedBox(height: 4),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // El RecipeForm lo dejé tal cual, solo agregué el "const" para mejor rendimiento
// class RecipeForm extends StatelessWidget {
//   const RecipeForm({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();

//     final TextEditingController _nombreDeLaReceta = TextEditingController();
//     final TextEditingController _DescripcionDeLaReceta = TextEditingController();
//     final TextEditingController _chef = TextEditingController();
//     final TextEditingController _imagenDeLareceta = TextEditingController();

//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               '🥗Agrega una nueva receta🥗',
//               style: TextStyle(color: Colors.blueAccent, fontSize: 24),
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               controler: _nombreDeLaReceta,
//               label: 'Nombre de la receta',
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Por favor ingrese un nombre';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               maxLines: 2,
//               controler: _DescripcionDeLaReceta,
//               label: 'Descripcion de la receta',
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Por favor ingrese la descripción';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               controler: _chef,
//               label: 'Chef',
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Por favor ingrese el Chef';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(
//               controler: _imagenDeLareceta,
//               label: 'Imagen de la receta',
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Por favor ingrese la imagen';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     Navigator.pop(context);
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blueAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   'Save Recipe',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controler,
//     required String? Function(String?) validator,
//     int maxLines = 1,
//   }) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(fontFamily: 'Quicksand', color: Colors.black),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       validator: validator,
//       maxLines: maxLines,
//     );
//   }
// }
