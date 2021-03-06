import 'package:shared_preferences/shared_preferences.dart';

class PreferencesData {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesData({required this.sharedPreferences});

  static const dailyRestaurant = 'dailyRestaurant';

  Future<bool> get isDailyRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurant) ?? false;
  }

  void setDailyRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurant, value);
  }
}