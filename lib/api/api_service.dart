import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/result.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsResult> restaurantList() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list of restaurants');
    }
  }

  Future<RestaurantResult> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant\'s detail');
    }
  }

  Future<RestaurantsResult> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  Future<CustomerReviewsResult> addReview(
    String restaurantId,
    String reviewerName,
    String reviewText,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: {'Content-Type': 'application/json', 'X-Auth-Token': '12345'},
      body: json.encode({
        'id': restaurantId,
        'name': reviewerName,
        'review': reviewText,
      }),
    );
    if (response.statusCode == 200) {
      return CustomerReviewsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post a review for this restaurant');
    }
  }
}
