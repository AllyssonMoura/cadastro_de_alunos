import 'package:sqflite/sqflite.dart';

class StudentDAO {
  static const _databaseName = "database.db";
  static late Database database;

  static Future<Database> _getConnection() async {
    String databasePath = await getDatabasesPath();

    String path = "$databasePath $_databaseName";

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE students (registration INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT)");
    });
    return database;
  }

  static Future<int> insertRecord(
      String table, Map<String, dynamic> data) async {
    database = await _getConnection();
    int result = await database.insert(table, data);
    database.close();
    return result;
  }

  static Future<List<Map<String, dynamic>>> listRecords(String table) async {
    database = await _getConnection();
    List<Map<String, dynamic>> data = await database.query(table);
    database.close();
    return data;
  }

  static Future<int> updateRecord(
      String table, Map<String, dynamic> data) async {
    database = await _getConnection();
    int result = await database.update(table, data,
        where: "registration=?", whereArgs: [data["registration"]]);
    database.close();
    return result;
  }

  static Future<int> removeRecord(String table, int id) async {
    database = await _getConnection();
    int result =
        await database.delete(table, where: "registration=?", whereArgs: [id]);
    database.close();
    return result;
  }
}
