import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sqlitoo",
      theme: ThemeData(
        primaryColor: Colors.lightGreen,
        primarySwatch: Colors.lightBlue,
        useMaterial3: true
      ),
      home: const Home(),
    );
  }
}
