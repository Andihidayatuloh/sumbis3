import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_api/comon/const.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/list_rest.dart';

class ListRestauranProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestauranProvider({required this.apiService}) {
    _fetchAllRest();
  }
  late ListRestauran _listRestauran;
  late RestState _state;
  String _message = "";
  String get message => _message;

  ListRestauran get result => _listRestauran;

  RestState get state => _state;

  Future<dynamic> _fetchAllRest() async {
    try {
      _state = RestState.loading;
      notifyListeners();
      final rest = await apiService.topHeadline();
      if (rest.restaurants.isEmpty) {
        _state = RestState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = RestState.hasData;
        notifyListeners();
        return _listRestauran = rest;
      }
    } on SocketException {
      _state = RestState.error;
      notifyListeners();
      return _message = "Tidak terkoneksi internet";
    } catch (e) {
      _state = RestState.error;
      notifyListeners();
      return _message = "Eror --> $e";
    }
  }
}
