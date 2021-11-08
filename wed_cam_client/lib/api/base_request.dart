import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


//String baseUrl = "http://127.0.0.1:6543";
String baseUrl = "54.233.178.31:6543";
//var url = Uri.https(baseUrl, '/books/v1/volumes', {'q': '{http}'});


Future fetchGet(String token, Uri url, context) async {
  try {
    http.Response response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Token $token",
        "Content-Type": "application/json; charset=utf-8",
      },
    ).timeout(const Duration(seconds: 12));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return response;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  } on TimeoutException catch (_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(
                "ERRO",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w800, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              content: new Text(
                "Tempo excedido",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white,
                      elevation: 1,// foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 20),
                    ))
              ]);
        });
  } catch (_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(
                "ERRO",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w800, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              content: new Text(
                "Encontramos um problema na operação.",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white,
                      elevation: 1,// foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 20),
                    ))
              ]);
        });
  }
}


Future fetchPost(Map map, String token, Uri url, context) async {
  try {
    var body = json.encode(map);
    var response = await http.post(
      url,
      headers: {
        "Content-Type":
        "application/json",
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Token $token"
      },
      body: body,
    ).timeout(const Duration(seconds: 12));
    return response;
  } on TimeoutException catch (_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(
                "ERRO",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w800, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              content: new Text(
                "Tempo excedido",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white,
                      elevation: 1,// foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 20),
                    ))
              ]);
        });
  } catch (_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(
                "ERRO",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w800, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              content: new Text(
                "Encontramos um problema na operação.",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white,
                      elevation: 1,// foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 20),
                    ))
              ]);
        });
  }
}


Future fetchPatch(Map map, String token, Uri url, context) async {
  try {
    var body = json.encode(map);
    var response = await http.patch(
      url,
      headers: {
        "Authorization": "Token $token",
        "Content-Type":
        "application/json; charset=utf-8",
        "Access-Control-Allow-Origin": "*",
      },
      body: body,
    ).timeout(const Duration(seconds: 12));
    return response;
  } on TimeoutException catch (_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(
                "ERRO",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w800, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              content: new Text(
                "Tempo excedido",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white,
                      elevation: 1,// foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 20),
                    ))
              ]);
        });
  } catch (_) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(
                "ERRO",
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w800, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              content: new Text(
                "Encontramos um problema na operação.",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white,
                      elevation: 1,// foreground
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 20),
                    ))
              ]);
        });
  }
}