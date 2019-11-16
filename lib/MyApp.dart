import 'dart:convert';

import 'package:flutter/material.dart';
import 'MyApp2.dart';
import 'materias.dart';

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => new _MyAppState();


}

class _MyAppState extends State<MyApp> {
  MyApp app= new MyApp();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Asistencia UES"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.white70,
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Comercio Electrónico"),
              accountEmail: new Text("correo"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: new NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTWwa83KBPQkFXW-JL0LEyBnifwd4t1bBzLU5S8uvnam-6daSvc"),
              ),
              decoration: new BoxDecoration(color: Colors.redAccent),
            ),
            new ListTile(
              leading: Icon(Icons.person),
              title: new Text("Perfil"),
            ),
            new ListTile(
              leading: Icon(Icons.adjust),
              title: new Text("Ajuste"),
            ),
            new ListTile(
              leading: Icon(Icons.lock),
              title: new Text("Cerrar Sesión"),
            ),
          ],
        ),
      ),
      body: new Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            new Card(
              margin: EdgeInsets.all(8.0),
              child: new InkWell(
                onTap: () {},
                splashColor: Colors.red,
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(Icons.people, size: 70.0),
                      Text(
                        "Perfil",
                        style: new TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Card(
              child: new InkWell(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new list()));
                },
                splashColor: Colors.red,
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(Icons.check_box, size: 70.0),
                      Text(
                        "Asistencia",
                        style: new TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Card(
              child: new InkWell(
                onTap: () {},
                splashColor: Colors.red,
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(Icons.star, size: 70.0),
                      Text(
                        "Insignias",
                        style: new TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Card(
              child: new InkWell(
                onTap: () {},
                splashColor: Colors.red,
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Icon(Icons.card_travel, size: 70.0),
                      Text(
                        "Rutas",
                        style: new TextStyle(fontSize: 17.0),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
