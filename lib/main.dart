import 'package:flutter/material.dart';
import 'package:qr_scanner/MyApp.dart' as prefix0;
import 'MyApp.dart';
import 'registro.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_scanner/Post.dart';
import 'package:http/http.dart' as http;
import 'MyApp.dart';
import 'registro.dart';
import 'registro.dart';

void main() {
  runApp(
    new MaterialApp(debugShowCheckedModeBanner: false, home: new Login()),
  );
}

class Login extends StatefulWidget {
  static String tag = 'login';
  @override
  _Login createState() => new _Login();
  // State<StatefulWidget> createState() => new _Login();

}

class _Login extends State<Login> {
  final formkey = new GlobalKey<FormState>();
  String _email, _contrasenia;

// Mensaje de Alerta
  void _mensajeAlerta() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Usuario no encontrado"),
            content: Text("Contraseña o correo erroneo"),
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
  
// Metodo post  
  Future<dynamic> post() async {
    final form = formkey.currentState;
    if (!form.validate()) {
      print('Formulario invalido'); //Validacion de formulario
    } else {
      final uri = 'http://35.232.215.93/apis/login.php'; //Post
      form.save(); // Guardar valores del formulario
      var peticion =
          '{"email":"' + _email + '", "password":"' + _contrasenia + '"}';
      final respuesta = await http.post(uri, body: peticion);
      final int codigo = respuesta.statusCode;
      if (codigo == 400 || codigo == 404) {
        _mensajeAlerta();
        return null; // Usuario no encontrado
      }
      if (codigo == 200) {
        print("Registro encontrado"); //Usuario encontrado
        print(respuesta.body);
       // MyApp a = new prefix0.MyApp();
       // a.setBody(json.decode(respuesta.body));
        Navigator.push(context,
              new MaterialPageRoute(builder: 
              (context) =>  MyApp(correo: json.decode(respuesta.body),)));
        return json.decode(respuesta.body);
        //Redirigir a la pagina principal
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('img/logoUes.png'),
      ),
    );

// Texto del correo
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (value) => value.isEmpty ? 'Correro Requerido' : null,
      onSaved: (value) => _email = value,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
// Contraseña
    final contrasenia = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? 'Contraseña Requerida' : null,
      onSaved: (value) => _contrasenia = value,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
//Boton de login
    final btnLogin = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        shadowColor: Colors.red,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async{
            //post(); 
            print(post());
            
          }, 
          color: Colors.red[200],
          child: Text('Iniciar Sesion', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
//Mensaje de contraseña olvidada
    final mensaje = FlatButton(
      child: Text(
        'Olvide la contraseña',
        style: TextStyle(color: Colors.black45),
      ),
      onPressed: () {}, //formulario para restrablecer contraseña 
    );

//Nuevo Usuario
    final nuevoUsurario = FlatButton(
      child: Text(
        'Crear nuevo usuario',
        style: TextStyle(color: Colors.black45),
      ),
      onPressed: () {
        Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new RegisterPage()));
      }, //Accion ==> Formulario para crear un usuario
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new Form(
          key: formkey,
          child: new ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              contrasenia,
              SizedBox(height: 24.0),
              btnLogin,
              nuevoUsurario,
              mensaje
            ],
          ),
        ),
      ),
    );
  }
}