import 'package:flutter/material.dart';

import '../db/planets.dart';
import '../db/sqlite.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  //Este objeto manipula la parte visual
  //Contenido dentro de la forma
  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _distanceCtr = TextEditingController();
  final TextEditingController _radioCtr = TextEditingController();
  final TextEditingController _lunasCtr = TextEditingController();
  Planets? planet;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forma de planetas"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameCtr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nombre"
                ),
                validator: (value) {
                  return value ?? "";
                },
              ),
              TextFormField(
                controller: _distanceCtr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Distancia"
                ),
                validator: (value) {
                  return value ?? "";
                },
              ),
              TextFormField(
                controller: _radioCtr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Radio"
                ),
                validator: (value) {
                  return value ?? "";
                },
              ),
              TextFormField(
                controller: _lunasCtr,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Lunas"
                ),
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "ERROOOOOOOOR";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () {
                _submit();
              },
                  child: Text("Submit")
              )
            ],
          ),
        ),
      ),
    );
  }
  void _submit() {
    if (_formkey.currentState!.validate() ?? false) {
      _formkey.currentState!.save();
      planet = Planets(
        0,
        _nameCtr.text,
        double.parse(_distanceCtr.text),
        double.parse(_radioCtr.text),
        int.parse(_lunasCtr.text),
      );
    }
  }

  void openDB() {
    Sqlite.db().whenComplete(
          () async {
        await agregar();
      },
    );
  }

  Future<void> agregar() async {
    List<Planets> planets = [
      planet!
    ];
    await Sqlite.add(planets);
  }
}



