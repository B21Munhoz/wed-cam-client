import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wed_cam_client/api/base_request.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';
import 'package:wed_cam_client/ui/utils/others.dart';
import 'package:wed_cam_client/ui/utils/dialogs.dart';
import 'package:http/http.dart' as http;

class CreateUser extends StatefulWidget {
  final isWeb;

  @override
  CreateUser({
    @required this.isWeb,
  }) : super();

  CreateUserState createState() => CreateUserState(
    isSafari: this.isWeb,
  );
}

class CreateUserState extends State<CreateUser> {
  final isSafari;

  CreateUserState({
    @required this.isSafari,
  });
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _username = TextEditingController();
    final TextEditingController _fullName = TextEditingController();
  final numberRegex = new RegExp(r"\(?0?\d{2}\)?[\s-]?\d{4,5}[\s-]?\d{4}");
  var client = new http.Client();
  bool _passVisible = false;
  bool _confirmPassVisible = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Cadastro de Usuário", []),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
                child: ListView(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _username,
                      cursorColor: textPink,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600,
                          color: textPink),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 16),
                        labelText: "Username",
                        labelStyle: TextStyle(color: textPink),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textPink, width: 0.0,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textPink, width: 2,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: errorRed, width: 2,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: errorRed, width: 0.0,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _pass,
                      cursorColor: textPink,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600,
                          color: textPink),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 16),
                        labelText: "Senha",
                        labelStyle: TextStyle(color: textPink),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textPink, width: 0.0,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textPink, width: 2,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: errorRed, width: 2,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: errorRed, width: 0.0,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(_passVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: textPink,
                            onPressed: () {
                              setState(() {
                                _passVisible = !_passVisible;
                              });
                            }),
                      ),
                      obscureText: !_passVisible,
                      validator: (val) {
                        if (val!.isEmpty) return 'Digite uma senha';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _confirmPass,
                      cursorColor: textPink,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600,
                          color: textPink),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 16),
                        labelText: "Confirmação de Senha",
                        labelStyle: TextStyle(color: textPink),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textPink, width: 0.0,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textPink, width: 2,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: errorRed, width: 2,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: errorRed, width: 0.0,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(_confirmPassVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            color: textPink,
                            onPressed: () {
                              setState(() {
                                _confirmPassVisible = !_confirmPassVisible;
                              });
                            }),
                      ),
                      obscureText: !_confirmPassVisible,
                      validator: (val) {
                        if (val!.isEmpty) return 'Digite uma senha';
                        if (val != _pass.text) return 'Senhas diferentes';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _fullName,
                      cursorColor: textPink,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600,
                          color: textPink),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 16),
                        labelText: "Nome Completo",
                        labelStyle: TextStyle(color: textPink),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textPink, width: 0.0,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textPink, width: 2,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: errorRed, width: 2,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: errorRed, width: 0.0,),
                          gapPadding: 3.3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) try {
                          Map map = {
                            'username': _username.text,
                            'password': _pass.text,
                            'name': _fullName.text,
                          };
                          var body = json.encode(map);
                          var url = Uri.http(baseUrl, '/api/register');
                            var uriResponse = await client.post(url,
                                headers: {
                                "Content-Type":
                                "application/json",
                                "Access-Control-Allow-Origin": "*"
                                },
                                body: body);

                            if ((uriResponse.statusCode == 200) ||
                                (uriResponse.statusCode == 202) ||
                                (uriResponse.statusCode == 201) ||
                                (uriResponse.statusCode == 204) ||
                                (uriResponse.statusCode == 203)) {
                              mySuccessConfirmDialog(context, signUpSucces, true);
                            } else if (uriResponse.statusCode == 400) {
                              myErrorConfirmDialog(
                                context,
                                "Problema encontrado com os dados fornecidos.",
                              );
                            } else if (uriResponse.statusCode == 401) {
                              myErrorConfirmDialog(
                                context,
                                "Operação não autorizada!",
                              );
                            } else if (uriResponse.statusCode == 500) {
                              myErrorConfirmDialog(
                                context,
                                loginErrorInternalContext,
                              );
                            } else {
                              myErrorConfirmDialog(
                                  context, "Desculpe, encontramos um problema.");
                            }
                          } catch (e) {
                            myErrorConfirmDialog(
                              context,
                              e.toString(),
                            );
                          } finally {}
                      },
                      color: goldenYellow,
                      elevation: 5,
                      splashColor: Colors.yellowAccent,
                      child: Text("CADASTRAR",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]))),
      ),
    );
  }
}
