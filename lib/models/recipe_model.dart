class Recipe {
  int id;
  String name;
  String chef;
  String category;
  String description;
  String image;
  List<String> recipes;

  // Constructor de la clase receta
  Recipe({
    required this.id,
    required this.name,
    required this.chef,
    required this.category,
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
      category: json['category'] ?? '', // Manejo de categoría opcional
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
      'category': category,
      'description': description,
      'image': image,
      'recipeSteps': recipes,
    };
  }

  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, chef: $chef, category: $category, description: $description, image: $image, recipeSteps: $recipes}';
  }
}
