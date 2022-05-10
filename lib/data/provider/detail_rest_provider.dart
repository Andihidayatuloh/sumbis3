import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurant_api/comon/const.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/detail_rest.dart';

class DetailRestProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  late DetailRestauran _detailRestauran;
  late RestState _state;
  String _message = "";

  DetailRestProvider({required this.id, required this.apiService}) {
    getDetailRest(id);
  }
  String get message => _message;
  DetailRestauran get result => _detailRestauran;
  RestState get state => _state;

  Future<dynamic> getDetailRest(String id) async {
    try {
      _state = RestState.loading;
      notifyListeners();
      final detailRest = await apiService.getDetailId(id);
      if (detailRest.error) {
        _state = RestState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = RestState.hasData;
        notifyListeners();
        return _detailRestauran = detailRest;
      }
    } on SocketException {
      _state = RestState.error;
      notifyListeners();
      return _message = "Tidak terkoneksi internet";
    } catch (e) {
      _state = RestState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
