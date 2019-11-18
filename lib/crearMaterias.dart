import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CrearMaterias extends StatefulWidget {
  @override
  _CrearMaterias createState() => new _CrearMaterias();
}

class _CrearMaterias extends State<CrearMaterias> {
  final formKey = new GlobalKey<FormState>();
  String _codigo;
  String _nombreMateria;
  String _idCarrera;
  String _idUsuario;
  String _seleccionD, _seleccionC;


  Map dataMaestros, dataCarreras;
  List maestros = List();
  List carreras = List();

  // Mensaje de Alerta
  void _mensajeAlerta() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Error al crear una nueva materia"),
            content: Text("Revise los valores ingresados"),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // Mensaje de Alerta
  void _mensajeExito() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Exito"),
            content: Text("Materia Registrada con Exito"),
            actions: <Widget>[
              RaisedButton(
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

// Metodos get para obtener los maestros y las carreras actualess
  Future getMaestros() async {
    http.Response response =
        await http.get("http://35.232.215.93/apis/docentes.php");
    dataMaestros = json.decode(response.body);
    if (response.statusCode == 400) {
      throw Exception('Error!');
    } else {
      setState(() {
       maestros = dataMaestros["data"];
      });
    }
  }

  Future getCarreras() async {
    http.Response response =
        await http.get("http://35.232.215.93/apis/carreras.php");
    dataCarreras = json.decode(response.body);
    if (response.statusCode == 400) {
      throw Exception('Error!');
    } else {
      setState(() {
        carreras = dataCarreras["data"];
      });
    }
  }

// Metodo post para agregar materias
  Future<dynamic> postMaterias() async {
    final form = formKey.currentState;
    final url = "http://35.232.215.93/apis/registro-materia.php";
    if (!form.validate()) {
      print("Formulario invalido");
    } else { 
      form.save();
      var peticion = '{"nombre_materia":"' +
          _nombreMateria +
          '", "codigo":"' +
          _codigo +
          '", "activo":true, "id_carrera":"' +
          _idCarrera +
          '", "id_usuario":"' +
          _idUsuario +
          '"}';

    final respuesta = await http.post(url, body: peticion);
    print(peticion);
     if (respuesta.statusCode == 400) {
       _mensajeAlerta();
      }
     if (respuesta.statusCode == 200) {
        _mensajeExito();
     }
    }
  }

  @override
  void initState() {
    super.initState();
    getCarreras();
    getMaestros();
  }

  //Componentes
  @override
  Widget build(BuildContext context) {
    //Campos de Texto
    final nombreMaterias = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: "Nombre"),
      validator: (value) => value.isEmpty ? 'Nombre Requerdio' : null,
      onSaved: (value) => _nombreMateria = value,
    );

    final codigoMateria = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      maxLength: 6,
      decoration: InputDecoration(labelText: "Codigo de Materia"),
      validator: (value) => value.isEmpty ? 'codigo de Materia Requerida' : null,
      onSaved: (value) => _codigo = value,
    );

    final carrera = new DropdownButton<dynamic>(
        isDense: true,
        hint: new Text("Seleccione un Carrera"),
        value: _seleccionC,
        onChanged: (nuevo) {
          setState(() {
            _seleccionC = nuevo;
          });
            for (int i =0; i < carreras.length;i++){
            if (_seleccionC == carreras[i]["nombre_carrera"]){
              _idCarrera = carreras[i]["id_carrera"];
              break;
            }
          } 
        },
        items: carreras.map((valor) {
          return new DropdownMenuItem<dynamic>(
            value: valor["nombre_carrera"],
            child: new Text(valor["nombre_carrera"]),
          );
        }).toList());

    final docente = new DropdownButton<dynamic>(
        isDense: true,
        hint: new Text("Seleccione un Docente"),
        value: _seleccionD,
        onChanged: (nuevo) {
          setState(() {
            _seleccionD = nuevo;
          });
          for (int i =0; i < maestros.length;i++){
            if (_seleccionD == maestros[i]["nombres"]){
              _idUsuario = maestros[i]["id_usuario"];
              break;
            }
          } 
          },
        items: maestros.map((valor) {
          return new DropdownMenuItem<dynamic>(
            value: valor["nombres"],
            child: new Text(valor["nombres"]),
          );
        }).toList()
        );

// boton de agregar materia
    final btnAgregar = FloatingActionButton(
      onPressed: () async {
        //postMaterias();
        print("Hijole");
        postMaterias();
      },
      child: Icon(Icons.create_new_folder),
    );

    return new Scaffold(
      body: new Center(
        child: new Form(
          key: formKey,
          child: new ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 10, right: 10),
            children: <Widget>[
              nombreMaterias,
              SizedBox(height: 10),
              codigoMateria,
              SizedBox(height: 10.0),
              carrera,
              SizedBox(height: 10),
              docente,
              SizedBox(height: 10),
              btnAgregar
            ],
          ),
        ),
      ),
    );
  }
}
