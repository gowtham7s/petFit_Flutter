import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql = "CREATE TABLE pets (id INTEGER PRIMARY KEY, name TEXT, dob TEXT, location TEXT, breed TEXT, ownerDetails TEXT);";
    await database.execute(sql);

    String sqlProducts = "CREATE TABLE products (id INTEGER PRIMARY KEY, name TEXT, price INTEGER, image TEXT, quantity INTEGER);";
    await database.execute(sqlProducts);

    String sqlSchedule = "CREATE TABLE schedule (id INTEGER PRIMARY KEY, petId INTEGER, name TEXT, whenDate TEXT, notes TEXT);";
    await database.execute(sqlSchedule);

    String sqlFeedback = "CREATE TABLE feedback (id INTEGER PRIMARY KEY, expression TEXT, category TEXT, feedback TEXT);";
    await database.execute(sqlFeedback);
  }
}