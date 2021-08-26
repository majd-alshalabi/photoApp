import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnId = '_id';
  static final columnName = '_name';
  static final columnEmail = '_email';
  static final columnPassword = '_password';
  static final columnFav = '_fav';

  static Future<Database> getDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnName TEXT , $columnEmail TEXT, $columnPassword TEXT,$columnFav TEXT)');
      },
    );
  }

  static Future<void> addRowToDataBase(
      String name, String email, String password, String fav) async {
    Database database = await getDatabase();
    await database.transaction(
      (txn) async {
        await txn.rawInsert(
            'INSERT INTO $table ($columnName ,$columnEmail, $columnPassword,$columnFav) VALUES("$name" , "$email" , "$password" , "$fav")');
      },
    );
  }

  static Future<List<Map>> getDataBaseInfo() async {
    return getDatabase().then((database) async {
      List<Map> list = await database.rawQuery('SELECT * FROM $table');
      return list;
    });
  }

  static Future<List<Map>> getTheTableRowData(String email) {
    return getDatabase().then((database) async {
      List<Map> item = await database
          .rawQuery('SELECT * FROM $table WHERE $columnEmail = "$email"');
      return item;
    });
  }
}
