import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as iguana;
import 'package:path/path.dart';
import 'package:sqlite/db/planets.dart';
import 'dart:io' as io;
class Sqlite {

  static Future<iguana.Database> db() async {
    // String rute = await iguana.getDatabasesPath();
    final io
        .Directory appDocumentDir = await getApplicationDocumentsDirectory();
    String rute = join(appDocumentDir.path, "databases", "planets.db");

    return iguana.openDatabase(
      rute,
      version: 1,
      singleInstance: true,
      onCreate: (db, version) async {
        await createDb(db);
      },
    );
  }

  static Future<void> createDb(iguana.Database db) async {
    const String sql = """
      create table planets(
        id integer primary key autoincrement not null,
        name text not null,
        sunDistance real not null,
        radio real not null,
        moons integer not null 
      )
    """;

    await db.execute(sql);
  }

  static Future<List <Planets>> consulta() async {
    final iguana.Database db = await Sqlite.db();
    final List<Map<String, dynamic>> query = await db.query("planets");
    return query.map(
          (e) {
        return Planets.deMap(e);
      },
    ).toList();
  }

  static Future<int> add(List<Planets> planets) async {
    final iguana.Database db = await Sqlite.db(); //abrir base
    int? error;
    for (Planets p in planets) {
      error = await db.insert("planets", p.toMap(),
          conflictAlgorithm: iguana.ConflictAlgorithm.replace);
    }
    db.close();
    return error!;
  }

  static Future<void> del(int i) async{
    final iguana.Database db = await Sqlite.db(); //abrir db
    await db.delete("planets", where: "id = ?", whereArgs: [i]);
  }
}
