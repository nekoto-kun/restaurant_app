import 'package:flutter/material.dart';

import '../api/api_service.dart';
import '../models/result.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurants();
  }

  late RestaurantsResult _restaurantsResult,
      _searchResult = RestaurantsResult();
  RestaurantResult? _restaurantResult;

  String _message = '';
  late ResultState _state;

  String get message => _message;

  RestaurantsResult get result => _restaurantsResult;
  RestaurantsResult get searchResult => _searchResult;
  RestaurantResult? get detail => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await apiService.restaurantList();
      if (data.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.Loading;
      final data = await apiService.restaurantDetail(id);
      if (data.restaurant == null) {
        _state = ResultState.NoData;
        _restaurantResult = null;
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        return _restaurantResult = data;
      }
    } catch (e) {
      _state = ResultState.Error;
      _restaurantResult = null;
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> searchRestaurant({String query = ''}) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      if (query.length > 0) {
        final data = await apiService.searchRestaurants(query);
        if (data.restaurants.isEmpty) {
          _state = ResultState.NoData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.HasData;
          notifyListeners();
          return _searchResult = data;
        }
      } else {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
