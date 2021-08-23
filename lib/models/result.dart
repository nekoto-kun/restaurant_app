import 'customer_review.dart';
import 'restaurant.dart';

abstract class Result {
  Result({
    this.error = true,
    this.message,
  });

  bool error;
  String? message;

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}

class RestaurantsResult extends Result {
  RestaurantsResult({
    this.count = 0,
    this.restaurants = const [],
    bool error = true,
    String? message,
  }) : super(
          error: error,
          message: message,
        );

  int? count, founded;
  List<Restaurant> restaurants;

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class RestaurantResult extends Result {
  RestaurantResult({
    this.restaurant,
    bool error = true,
    String? message,
  }) : super(
          error: error,
          message: message,
        );

  Restaurant? restaurant;

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );
}

class CustomerReviewsResult extends Result {
  CustomerReviewsResult({
    this.customerReviews = const [],
    bool error = true,
    String? message,
  }) : super(
          error: error,
          message: message,
        );

  List<CustomerReview> customerReviews;

  factory CustomerReviewsResult.fromJson(Map<String, dynamic> json) =>
      CustomerReviewsResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );
}
