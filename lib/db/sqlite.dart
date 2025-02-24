import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as iguana;
import 'package:path/path.dart';
import 'package:sqlite/db/planets.dart';
class Sqlite{

  static Future<iguana.Database> db() async{
    String rute = await iguana.getDatabasesPath();
    return iguana.openDatabase(
        join(rute, "planets.db"),
        version: 1,
        singleInstance: true,
        onCreate: (db, version) async{
          await createDb(db);
        },
    );
  }
  static Future<void> createDb(iguana.Database db) async{
     const String sql = """
      create table planets(
      id integer primary key autoincrement not null,
      name as text not null,
      sunDistance real not null,
      radio real not null,
      moons integer not null 
      )
    """;

     await db.execute(sql);
  }

  static Future<List <Planets>> consulta() async{
    final iguana.Database db = await Sqlite.db();
    final List<Map<String, dynamic>> query = await db.query("planets");
    return query.map(
          (e){
            return Planets.deMap(e);
          },
    ).toList();
  }
}