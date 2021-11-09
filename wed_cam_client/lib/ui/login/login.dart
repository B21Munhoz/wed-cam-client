import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wed_cam_client/business_logic/login_data.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';
import 'package:wed_cam_client/ui/utils/dialogs.dart';
import 'package:wed_cam_client/ui/login/login_form.dart';
import 'package:wed_cam_client/ui/login/register.dart';
import 'package:wed_cam_client/api/base_request.dart';
import 'package:wed_cam_client/ui/event/event.dart';


class CustomLoginForm extends StatefulWidget {
  final isWeb;
//  final myTheme;

  CustomLoginForm({
    @required this.isWeb,
//    @required this.myTheme,
  });

  @override
  CustomLoginFormState createState() => CustomLoginFormState(
    isWeb: isWeb,
//    myTheme: myTheme,
  );
}

class CustomLoginFormState extends State<CustomLoginForm> {
  String user = "";
  String password = "";
  final isWeb;
//  final myTheme;
  bool isSafari = false;


  CustomLoginFormState({
    @required this.isWeb,
//    @required this.myTheme,
  });
  var _data = new LoginData();
  final StreamController<LoginData> _streamController =
  new StreamController<LoginData>();

  @override
  void initState() {
    _data = new LoginData();
    _streamController.add(_data);
    this.isSafari = this.isWeb;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  var client = new http.Client();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoginData>(
        stream: _streamController.stream,
        initialData: _data,
        builder: (context, snapshot) {
//          bool x = true;
          if ((snapshot.data != null) && (snapshot.data!.gotValue)) {
            _streamController.add(_data);
            return new WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                backgroundColor: bgPink,
                body: Container(
                  alignment: Alignment.center,
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                "images/wedding-camera.png",
                                width: 200,
                                height: 200,
                              ),
                            ),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Wedding",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: goldenYellow,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Cam",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: textPink,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // USUÁRIO
                            userFormField(_data),
                            // SENHA
                            passwordFormField(_data, () {
                              setState(() {
                                _data.passwordVisible = !_data.passwordVisible;
                              });
                            }),
                            // ROW DOS BOTÕES
                            Container(
                              child: SizedBox(
                                width: 325,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    signUpButton(_data, () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateUser(
                                            isWeb: isWeb,
                                          ),
                                        ),
                                      );
                                    }),
                                    signInButton(
                                      _data,
                                          () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return loginEnterDialog();
                                                });
                                            Map map = {
                                              'username': _data.username,
                                              'password': _data.password
                                            };
                                            var body = json.encode(map);
                                            var url = Uri.http(baseUrl, '/api/login');
                                            var uriResponse = await client.post(
                                              url,
                                            headers: {
                                            "Content-Type":
                                            "application/json",
                                            "Access-Control-Allow-Origin": "*"
                                            },
                                              body: body,
                                            ).whenComplete(() {}).timeout(const Duration(seconds: 10));
                                            if (uriResponse.statusCode == 200) {
                                              _data.setLoginInfo();
                                              var body =
                                              jsonDecode(uriResponse.body)
                                              as Map;
                                              _data.token = body['token'];

                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EventsPage(
                                                    token: _data.token,
                                                    isWeb: isWeb,
                                                    refWidget: CustomLoginForm(
                                            isWeb: isWeb, ),
                                                  ),
                                                ),
                                              );
                                              Navigator.pop(context, true);
                                            } else if (uriResponse.statusCode ==
                                                400) {
                                              Navigator.pop(context, true);
                                              myErrorConfirmDialog(
                                                context,
                                                loginErrorAuthContext,
                                              );
                                            } else if (uriResponse.statusCode ==
                                                500) {
                                              Navigator.pop(context, true);
                                              myErrorConfirmDialog(
                                                context,
                                                loginErrorInternalContext,
                                              );
                                            } else {
                                              Navigator.pop(context, true);
                                              myErrorConfirmDialog(
                                                context,
                                                loginErrorInternalContext,
                                              );
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
                                                            },
                                                            child: Text(
                                                              "OK",
                                                              style: TextStyle(fontSize: 20),
                                                            ))
                                                      ]);
                                                });
                                          } catch (e) {
                                            print(e);
                                            //Navigator.pop(context, true);
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
                                                        "Não foi possível comunicar com o servidor.",
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
                                          } finally {
//                          client.close();
                                          }
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            _streamController.add(_data);
            return myLoading();
          }
        });
  }
}
