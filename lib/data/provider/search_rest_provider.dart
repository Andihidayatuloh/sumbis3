import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_api/comon/const.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/search_rest.dart';

enum SearchRestState{loading, noData,hasData,eror}

class SearchRestProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestProvider({required this.apiService}) {
    fetchAllRestaurant(search);
  }

  SearchRest? _restaurantResult;
  RestState? _state;
  String _message = '';
  String _search = '';

  String get message => _message;

  SearchRest? get result => _restaurantResult;

  String get search => _search;

  RestState? get state => _state;

  Future<dynamic> fetchAllRestaurant(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = RestState.loading;
        _search = search;
        notifyListeners();
        final restaurant = await apiService.getTextField(search);
        if (restaurant.restaurants.isEmpty) {
          _state = RestState.noData;
          notifyListeners();
          return _message = 'Empty Data Boss!';
        } else {
          _state = RestState.hasData;
          notifyListeners();
          return _restaurantResult = restaurant;
        }
      } else {
        return _message = 'text null';
      }
    } on SocketException {
      _state = RestState.error;
      notifyListeners();
      return _message =
          "Tidak Terkoneksi Internet";
    } catch (e) {
      _state = RestState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
