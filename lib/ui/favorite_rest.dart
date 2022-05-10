import 'package:flutter/material.dart';
import 'package:restaurant_api/comon/const.dart';
import 'package:restaurant_api/data/provider/data_base.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/widget/rest_list.dart';

class RestFavoritPage extends StatelessWidget {
  const RestFavoritPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataFavoritProvider>(
      builder: (context, state, _) {
        if (state.state == RestState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == RestState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              var restaurant = state.favorites[index];
              return CardRest(
                restaurant: restaurant,
              );
            },
          );
        } else if (state.state == RestState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == RestState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
