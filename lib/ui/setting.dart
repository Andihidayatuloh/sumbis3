import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/provider/scedul.dart';

class RestSettingPage extends StatefulWidget {
  const RestSettingPage({Key? key}) : super(key: key);

  @override
  State<RestSettingPage> createState() => _RestSettingPageState();
}

class _RestSettingPageState extends State<RestSettingPage> {
  String counterNumberPrefs = 'counterNumber';

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text('Scheduling'),
        trailing:
            Consumer<SchedulProvider>(builder: (context, scheduled, _) {
          return Switch.adaptive(
            value: scheduled.isScheduled,
            onChanged: (value) async {
              scheduled.enableDailyRestaurant(value);
              scheduled.scheduledRestaurant(value);
            },
          );
        }));
  }
}
