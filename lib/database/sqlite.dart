import 'package:restaurant_api/data/model/list_rest.dart';
import 'package:sqflite/sqflite.dart';

class SQLFavorit {
  static SQLFavorit? _instance;
  static Database? _database;

  SQLFavorit._internal() {
    _instance = this;
  }

  factory SQLFavorit() => _instance ?? SQLFavorit._internal();

  static const String _tblFavorite = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating TEXT
           )
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    } else {
      null;
    }

    return _database;
  }

  Future<void> insertFavorite(RestaurantList restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restaurant.toJson());
  }

  Future<List<RestaurantList>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((res) => RestaurantList.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
