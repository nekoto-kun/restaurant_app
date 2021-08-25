import 'category.dart';
import 'customer_review.dart';
import 'menu.dart';

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Category>? categories;
  Menu? menus;
  double? rating;
  List<CustomerReview>? customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic>? json) => Restaurant(
        id: json?["id"],
        name: json?["name"],
        description: json?["description"],
        city: json?["city"],
        address: json?["address"],
        pictureId: json?["pictureId"],
        categories: List<Category>.from(
            json?["categories"]?.map((x) => Category.fromJson(x)) ?? []),
        menus: Menu.fromJson(json?["menus"]),
        rating: json?["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
            json?["customerReviews"]?.map((x) => CustomerReview.fromJson(x)) ??
                []),
      );
}
