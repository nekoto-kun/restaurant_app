import 'dart:convert';

import 'menu.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late List<Menu> foods;
  late List<Menu> drinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    foods = restaurant['menus']['foods']
        .map<Menu>((item) => Menu.fromJson(item))
        .toList();
    drinks = restaurant['menus']['drinks']
        .map<Menu>((item) => Menu.fromJson(item))
        .toList();
  }
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final parsed = jsonDecode(json);
  return parsed['restaurants']
      .map<Restaurant>((item) => Restaurant.fromJson(item))
      .toList();
}
