import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

final String databaseName = 'sample.db';
DatabaseFactory dbFactory = databaseFactoryIo;

Future addJsonToDatabase(var data) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  Database db = await dbFactory.openDatabase(appDocDir.path + databaseName);
  var store = StoreRef.main();
  await store.record('data').put(db, data);
}

Future<Map> getJsonFromDatabase() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  Database db = await dbFactory.openDatabase(appDocDir.path + databaseName);
  var store = StoreRef.main();
  return await store.record('data').get(db) as Map;
}
