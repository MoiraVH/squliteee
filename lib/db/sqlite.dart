import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as iguana;
class Sqlite{

  static Future<iguana.Database> db() async{
    String rute = iguana.getDatabasesPath();
  }
}