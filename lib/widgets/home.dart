import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite/db/sqlite.dart';

import '../db/planets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Planets>? planetario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planetario = [];
    openDB();
  }

  @override //contrario a init state
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          consultar();
          if (planetario!.isEmpty) {
            return CircularProgressIndicator(
              color: Colors.grey,
            );
          } else {
            return ListView.builder(
                itemCount: planetario!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    focusColor: Colors.lime,
                      hoverColor: Colors.lightGreen,
                      child: Card(
                        elevation: 1,
                        child: CupertinoListTile(
                          leading: const  Icon(CupertinoIcons.circle),
                          title: Text(planetario![index].name!),
                          subtitle: Text("Lunas: ${planetario![index].moons!}"),
                          onTap: () {
                            remove(planetario![index].id! );
                          },
                        ),
                      )
                  );
                }
            );
          }
        },),
      ),
    );
  }

  Future<void> consultar() async{
    planetario = await Sqlite.consulta().whenComplete((){
      setState(() {

      });
    });
  }

  void openDB() {
    Sqlite.db().whenComplete(() async {
      await agregar();
      },
    ); //Crea el dato solo cuando esta seguro de que acabo el hilo
  }

  Future<void> agregar() async{
    List<Planets> planets = [
      Planets(1, "Mercury", 4,  5, 0),
      Planets(2, "Venus",   5,  3, 0),
      Planets(3, "Earth",   8,  7, 1),
      Planets(4, "Mars",    9,  6, 2),
      Planets(5, "Saturn",  10, 5, 24),
      Planets(6, "Uranus",  24, 5, 0),
      Planets(7, "Neptune", 24, 5, 0),
    ];
    await Sqlite.add(planets);


  }

  Future<void> remove(int index) async{
    await Sqlite.del(index).whenComplete(() {
      consultar();
      setState(() {

      });
    });
  }
}
