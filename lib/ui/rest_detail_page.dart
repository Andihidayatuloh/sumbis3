import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/comon/const.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/model/list_rest.dart';
import 'package:restaurant_api/data/provider/detail_rest_provider.dart';
import 'package:restaurant_api/widget/rest_detail.dart';

class RestDetailPage extends StatelessWidget {
  static const routeName = '/rest_detail';
  final RestaurantList idRest;

  const RestDetailPage({Key? key, required this.idRest}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Daftar Restauran"),
      ),
      backgroundColor: Colors.grey.shade100,
      body: ChangeNotifierProvider<DetailRestProvider>(
        create: (_) => DetailRestProvider(apiService: ApiService(), id: idRest.id),
        child: Consumer<DetailRestProvider>(builder: (context, state, _) {
          if (state.state == RestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == RestState.hasData) {
            return RestDetail(restaurant: state.result.restaurant,
                restaurantList: idRest,);
          } else if (state.state == RestState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == RestState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(""));
          }
        }),
      ),
    );
  }
}
