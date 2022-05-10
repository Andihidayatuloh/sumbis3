import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/model/list_rest.dart';
import 'package:restaurant_api/data/model/search_rest.dart';
import 'package:restaurant_api/data/provider/search_rest_provider.dart';
import 'package:restaurant_api/widget/rest_list.dart';

class RestSearchPage extends StatefulWidget {
  const RestSearchPage({Key? key}) : super(key: key);
  @override
  State<RestSearchPage> createState() => _RestSearchPageState();
}

class _RestSearchPageState extends State<RestSearchPage> {
  TextEditingController controller = TextEditingController();
  String hasil = "";
  SearchRest? restaurantSearch;

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchRestProvider>(builder: (context, state, _) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Positioned(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 50,
                            color: Colors.grey.shade500.withOpacity(0.23))
                      ]),
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.23)),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    onChanged: (String query) {
                      if (query.isNotEmpty) {
                        setState(() {
                          hasil = query;
                        });
                        state.fetchAllRestaurant(hasil);
                      }
                    },
                  ),
                ),
              ),
              (hasil.isEmpty)
                  ? const Center(
                      child: Text('Tuliskan apa yang ingin dicari!'),
                    )
                  : buildSearch(context)
            ],
          ),
        ),
      );
    });
  }
}

Widget buildSearch(BuildContext context) {
  return Consumer<SearchRestProvider>(
    builder: (context, state, _) {
      if (state.state == SearchRestState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == SearchRestState.hasData) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.result!.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result!.restaurants[index];
            return CardRest(restaurant: restaurant);
          },
        );
      } else if (state.state == SearchRestState.noData) {
        return Center(child: Text(state.message));
      } else if (state.state == SearchRestState.eror) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: Text(''));
      }
    },
  );
}
