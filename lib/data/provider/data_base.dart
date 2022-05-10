import 'package:flutter/cupertino.dart';
import 'package:restaurant_api/comon/const.dart';
import 'package:restaurant_api/data/model/list_rest.dart';
import 'package:restaurant_api/database/sqlite.dart';

class DataFavoritProvider extends ChangeNotifier {
  final SQLFavorit database;

  DataFavoritProvider({required this.database}) {
    _getFavorites();
  }

  RestState _state = RestState.loading;
  RestState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantList> _favorites = [];
  List<RestaurantList> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await database.getFavorite();
    if (_favorites.isNotEmpty) {
      _state = RestState.hasData;
    } else {
      _state = RestState.noData;
      _message = Const.textEmptyData;
    }
    notifyListeners();
  }

  void tambahFavorite(RestaurantList restaurant) async {
    try {
      await database.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = RestState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> myFavorited(String id) async {
    final favoriteRestaurant = await database.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void hapusFavorite(String id) async {
    try {
      await database.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = RestState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
