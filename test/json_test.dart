import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_api/data/model/list_rest.dart';

var testRestaurant = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Kita",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
  "pictureId": "25",
  "city": "Gorontalo",
  "rating": 4
};
void main() {
  test("Test Parsing", () async {
    var result = RestaurantList.fromJson(testRestaurant).id;

    expect(result, "s1knt6za9kkfw1e867");
  });
}
