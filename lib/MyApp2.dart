import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:simple_permissions/simple_permissions.dart';

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => new _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  String _reader = '';
  Permission permission = Permission.Camera;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Asistencia'),
        backgroundColor: Colors.red,
        
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            new RaisedButton(
              splashColor: Colors.pinkAccent,
              color: Colors.red,
              child: new Text(
                "Marcar Asistencia",
                style: new TextStyle(fontSize: 20.0, color: Colors.white) ,
              ),
              onPressed: scan,
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            new Text(
              '$_reader',
              softWrap: true,
              style: new TextStyle(fontSize: 30.0, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }

  requestPermission() async {
    bool result =
        (await SimplePermissions.requestPermission(permission)) as bool;
  }

  scan() async {
    try {
      String reader = await BarcodeScanner.scan();
      if (!mounted) {
        return;
      }
      setState(() => _reader = reader);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        requestPermission();
      } else {
        setState(() => _reader = "unknown error $e");
      }
    } on FormatException {
      setState(() => _reader = "user return without sanning");
    }
  }
}
