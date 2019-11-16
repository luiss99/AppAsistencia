import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
 
class Post {
  final int code;
  final String message;

  String respuesta;
  
  Post({this.code, this.message});
 
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      code: json['code'],
      message: json['message'],
    );
  }
 
  Map toMap() {
    var map = new Map<String, dynamic>();
    map["code"] = code;
    map["message"] = message;

    return map;
  }
}
 
Future<String> createPost(String url, {Map body}) async {
  return http.post(url, body: jsonEncode(body)).then((http.Response response) {
    
    final int statusCode = response.statusCode;    
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return response.body;
  });
}
 

 
