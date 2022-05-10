import 'dart:convert';

ListRestauran listRestauranFromJson(String str) =>
    ListRestauran.fromJson(json.decode(str));

String restaurantResultToJson(ListRestauran data) => json.encode(data.toJson());

class ListRestauran {
  ListRestauran({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<RestaurantList> restaurants;

  factory ListRestauran.fromJson(Map<String, dynamic> json) => ListRestauran(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurants: List<RestaurantList>.from(
          json["restaurants"].map((x) => RestaurantList.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantList {
  RestaurantList({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
