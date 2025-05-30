// class Recipe { 
//   int id;
//   String name;
//   String chef;
//   String description;
//   String image;
//    List<String> recipeSteps;

// //   Constructor de la clase receta
//   Recipe({
//     required this.id,
//     required this.name,
//     required this.chef,
//     required this.description,
//     required this.image,
//    required this.recipeSteps,
//   });


// //   factory mejor manejo y cambio de nuestra clase
//   factory Recipe.fromJson(Map<String, dynamic> json) {
//     return Recipe(
//       id: json['id'],
//       name: json['name'],
//       chef: json['chef'],
//       description: json['description'],
//       image: json['image'],
//     recipeSteps: List<String>.from(json['recipe']),
//     );
//   }
// //   conversion  a json]
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'chef': chef,
//       'description': description,
//       'image': image,
//       'recipe': recipeSteps,
//     };
//   } 

//   @override
//   String toString() {
//     return 'Recipe{id: $id, name: $name, chef: $chef, description: $description, image: $image}';
//   }
// }

class Recipe {
  int id;
  String name;
  String chef;
  String description;
  String image;
  List<String> recipes;

  // Constructor de la clase receta
  Recipe({
    required this.id,
    required this.name,
    required this.chef,
    required this.description,
    required this.image,
    required this.recipes,
  });

  // Factory para crear una instancia desde un mapa (por ejemplo, de JSON)
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      chef: json['chef'],
      description: json['description'],
      image: json['image'],
      recipes: List<String>.from(json['recipeSteps'] ?? []),
    );
  }

  // Conversión a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'chef': chef,
      'description': description,
      'image': image,
      'recipeSteps': recipes,
    };
  }

  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, chef: $chef, description: $description, image: $image, recipeSteps: $recipes}';
  }
}