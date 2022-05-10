import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_api/comon/preference_sql.dart';
import 'package:restaurant_api/data/notifikasi/background.dart';
import 'package:restaurant_api/data/notifikasi/setting.dart';

class SchedulProvider extends ChangeNotifier {
  PreferencesData preferencesData;
  SchedulProvider({required this.preferencesData}) {
    _getDailyRestaurantPreference();
  }

  bool _isScheduled = true;
  bool get isScheduled => _isScheduled;

  void _getDailyRestaurantPreference() async {
    _isScheduled = await preferencesData.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesData.setDailyRestaurant(value);
    scheduledRestaurant(value);
    _getDailyRestaurantPreference();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      debugPrint('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeData.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
