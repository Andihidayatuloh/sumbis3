import 'package:flutter/material.dart';
import 'package:restaurant_api/data/notifikasi/notifikasidata.dart';
import 'package:restaurant_api/ui/favorite_rest.dart';
import 'package:restaurant_api/ui/rest_detail_page.dart';
import 'package:restaurant_api/ui/rest_list_page.dart';
import 'package:restaurant_api/ui/rest_search_page.dart';
import 'package:restaurant_api/ui/setting.dart';

class RestHomePage extends StatefulWidget {
  static const routeName = '/home';
  const RestHomePage({Key? key}) : super(key: key);

  @override
  _RestHomePageState createState() => _RestHomePageState();
}

class _RestHomePageState extends State<RestHomePage> {
  int _selectedIndex = 0;
  // ignore: unused_field
  static const TextStyle optioStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOption = <Widget>[
    const RestListPage(),
    const RestaurantSearchPage(),
    const RestFavoritPage(),
    const RestSettingPage(),
  ];
  final NotificationData _notificationData = NotificationData();

  @override
  // ignore: override_on_non_overriding_member
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationData
        .configureSelectNotificationSubject(RestDetailPage.routeName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: const Text(
          "Restaurant",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: _widgetOption.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      unselectedFontSize: 0,
      selectedFontSize: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Seacrh", icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: "Favorite", icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(
            label: "Setting", icon: Icon(Icons.settings))
      ],
      onTap: (index) {
        _onItemTapped(index);
      },
    );
  }
}
