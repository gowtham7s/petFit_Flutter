import 'package:pet_fit/database/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  late DatabaseConnection _databaseConnection;
  DBManager() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;
  Future<Database?> get database async {
    if(_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //Insert Pet
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read all record
  readData(table) async {
    var connection = await database;
    return connection?.query(table);
  }

  //Read a single record by ID
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Read a single record by specific field
  readDataByField(table, field, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: '$field=?', whereArgs: [itemId]);
  }

  //Update record
  updateData(table, data) async {
    var connection = await database;
    return await connection?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete a single record by ID
  deleteDataById(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}