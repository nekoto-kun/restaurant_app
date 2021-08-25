import 'category.dart';

class Menu {
  Menu({
    required this.foods,
    required this.drinks,
  });

  List<Category>? foods;
  List<Category>? drinks;

  factory Menu.fromJson(Map<String, dynamic>? json) => Menu(
        foods: List<Category>.from(
            json?["foods"]?.map((x) => Category.fromJson(x)) ?? []),
        drinks: List<Category>.from(
            json?["drinks"]?.map((x) => Category.fromJson(x)) ?? []),
      );
}
