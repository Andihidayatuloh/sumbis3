import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/comon/navigation.dart';
import 'package:restaurant_api/comon/preference_sql.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/list_rest.dart';
import 'package:restaurant_api/data/notifikasi/background.dart';
import 'package:restaurant_api/data/notifikasi/notifikasidata.dart';
import 'package:restaurant_api/data/provider/data_base.dart';
import 'package:restaurant_api/data/provider/list_rest_provider.dart';
import 'package:restaurant_api/data/provider/scedul.dart';
import 'package:restaurant_api/data/provider/search_rest_provider.dart';
import 'package:restaurant_api/database/sqlite.dart';
import 'package:restaurant_api/ui/home_page.dart';
import 'package:restaurant_api/ui/rest_detail_page.dart';
import 'package:restaurant_api/ui/rest_list_page.dart';
import 'package:restaurant_api/widget/splash_screan.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationData _notification = NotificationData();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await _notification.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DataFavoritProvider(database: SQLFavorit()),
        ),
        ChangeNotifierProvider(
            create: (_) => ListRestauranProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => SearchRestProvider(apiService: ApiService())),
        ChangeNotifierProvider(
          create: (_) => SchedulProvider(
            preferencesData: PreferencesData(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Restaurant',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const SplashScreen(),
        initialRoute: RestHomePage.routeName,
        routes: {
          RestHomePage.routeName: (context) => const RestHomePage(),
          RestListPage.routName: (context) => const RestListPage(),
          RestDetailPage.routeName: (context) => RestDetailPage(
              idRest:
                  ModalRoute.of(context)?.settings.arguments as RestaurantList)
        },
      ),
    );
  }
}
