import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_api/comon/navigation.dart';
import 'package:restaurant_api/data/model/list_rest.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationData {
  static NotificationData? _instance;

  NotificationData._internal() {
    _instance = this;
  }

  factory NotificationData() => _instance ?? NotificationData._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListRestauran restaurantResult) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dicoding news channel";
    var random = restaurantResult
        .restaurants[Random().nextInt(restaurantResult.restaurants.length - 1)];

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = random.name;
    var titleNews = random.description;
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurantResult.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = ListRestauran.fromJson(json.decode(payload));
        var resto = data.restaurants[0];
        Navigation.intentWithData(route, resto);
      },
    );
  }
}
