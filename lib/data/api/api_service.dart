import 'dart:convert';
import 'package:restaurant_api/data/model/detail_rest.dart';
import 'package:restaurant_api/data/model/list_rest.dart';
import 'package:restaurant_api/data/model/search_rest.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _url = 'https://restaurant-api.dicoding.dev/';

  Future<ListRestauran> topHeadline() async {
    final response = await http.get(Uri.parse(_url + "list"));
    if (response.statusCode == 200) {
      return ListRestauran.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed To load top Headline");
    }
  }

  Future<SearchRest> getTextField(String query) async {
    final response = await http.get(Uri.parse(_url + "search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRest.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed To load top Headline");
    }
  }

  Future<DetailRestauran> getDetailId(String id) async {
    final response = await http.get(Uri.parse(_url + "detail/" + id));
    if (response.statusCode == 200) {
      return DetailRestauran.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed To load top Headline");
    }
  }
}
