import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_scanner/Post.dart';
import 'package:qr_scanner/behaviors/hiddenScrollBehavior.dart';
import 'main.dart';


class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{
String _email;
String _password;
String _nombres;
String _apellidos;
String _usuario;
String _direccion;
String rawJson;
String validador = "Por favor verifique los siguientes campos: ";
static final CREATE_POST_URL = 'http://35.232.215.93/apis/singup.php';

final _formKey = GlobalKey<FormState>();
final _scaffoldkey = GlobalKey<ScaffoldState>();
bool _isRegistering = false;

_register() async {
    if (_isRegistering) return ;
    setState(() {
    _isRegistering = true; 
    });
  _scaffoldkey.currentState.showSnackBar(SnackBar(
    content: Text('Registering user'),
  ));
    
  final form = _formKey.currentState;
 if(!form.validate()){
   _scaffoldkey.currentState.hideCurrentSnackBar();
   _scaffoldkey.currentState.showSnackBar(SnackBar(
    content: Text(validador),
    
  ));
  validador = "Por favor verifique los siguientes campos: ";
   setState(() {
    _isRegistering = false; 
   });
   return;
 }
form.save();
rawJson = '{"nombres":"'+_nombres+'", "apellidos":"'+_apellidos	+'", "user":"'+_usuario	+'", "pass":"'+_password	+'","email":"'+_email	+'", "id_tipo_usuario":"2", "direccion":"'+_direccion	+'"}';
            Map<String, dynamic> mapp = jsonDecode(rawJson);
            await createPost(CREATE_POST_URL, body: mapp);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key:  _formKey,
            child: ListView(
              children: <Widget>[
                new Image.asset(
                            'lib/images/minervaLogo.png',
                          width: 80.0,
                          height: 100.0, 
                          ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Nombres'),
                  validator: (val){
                    if(val.isEmpty){
                      validador = validador + " Nombres";
                      return 'Por favor ingrese un nombre valido';
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (val){
                    setState(() {
                     _nombres = val; 
                    });
                  },  
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Apellidos'),
                  validator: (val){
                    if(val.isEmpty){
                      validador = validador + " Apellidos";
                      return 'Por favor ingrese un apellido valido';
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (val){
                    setState(() {
                     _apellidos = val; 
                    });
                  },  
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Usuario'),
                  validator: (val){
                    if(val.isEmpty){
                      validador = validador + " Usuario";
                      return 'Por favor ingrese un usuario valido';
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (val){
                    setState(() {
                     _usuario = val; 
                    });
                  },  
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (val){
                    if(val.isEmpty){
                      validador = validador + " Password";
                      return 'Por favor ingrese un password valido';
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (val){
                    setState(() {
                     _password = val; 
                    });
                  },
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (val){
                    if(val.isEmpty){
                      validador = validador + " Email";
                      return 'Por favor ingrese un email valido';
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (val){
                    setState(() {
                     _email = val; 
                    });
                  },  
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Direccion'),
                  validator: (val){
                    if(val.isEmpty){
                      validador = validador + " Direccion";
                      return 'Por favor ingrese un direccion valida';
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (val){
                    setState(() {
                     _direccion = val; 
                    });
                  },  
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Bienvenidos a la App de Asistencia!',
                  style: TextStyle(color: Color.fromARGB(255, 200,  200, 200)
                    ),
                    ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
            _register();
            //Navigator.of(context).pushNamed('/login');
        },
        child: Icon(Icons.person_add),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(onPressed: (){
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new Login()));
        },
        child: Text('Ya poseo un cuenta'),)
      ],
    );
  }
  
}