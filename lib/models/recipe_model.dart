class Recipe {
  String name;
  String chef;
  String description;
  String image;
  List<String> recipeSteps;

  //Constructor de la clase receta
  Recipe({
    required this.name,
    required this.chef,
    required this.description,
    required this.image,
    required this.recipeSteps,
  });


  //factory mejor manejo y cambio de nuestra clase
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      chef: json['chef'],
      description: json['description'],
      image: json['image'],
      recipeSteps: List<String>.from(json['recipe']),
    );
  }
  //conversion  a json]
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'chef': chef,
      'description': description,
      'image': image,
      'recipe': recipeSteps,
    };
  } 

  @override
  String toString() {
    return 'Recipe{name: $name, chef: $chef, description: $description, image: $image, recipeSteps: $recipeSteps}';
  }
}