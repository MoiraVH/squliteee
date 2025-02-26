import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqlite/widgets/app.dart';

void main() {
  // en windows instalar sqlite con choco
  if (!kIsWeb){
    sqfliteFfiInit();
  } else {
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(const App());

}
