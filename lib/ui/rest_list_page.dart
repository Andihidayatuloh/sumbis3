import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/comon/const.dart';
import 'package:restaurant_api/data/api/api_service.dart';
import 'package:restaurant_api/data/provider/list_rest_provider.dart';
import 'package:restaurant_api/widget/rest_list.dart';

class RestListPage extends StatelessWidget {
  static const routName = "/rest_list";
  const RestListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListRestauranProvider>(
      create: (_) => ListRestauranProvider(apiService: ApiService()),
      child: Consumer<ListRestauranProvider>(
        builder: (context, state, _) {
          if (state.state == RestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == RestState.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var Rest = state.result.restaurants[index];
                  return CardRest(restaurant: Rest);
                });
          } else if (state.state == RestState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == RestState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(""));
          }
        },
      ),
    );
  }
}
