import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wed_cam_client/business_logic/login_data.dart';
import 'package:wed_cam_client/ui/aux/my_palett.dart';
import 'package:wed_cam_client/ui/aux/dialogs.dart';
import 'package:wed_cam_client/ui/login/login_form.dart';


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
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  signUpButton(_data, () async {

                                  }),
                                  signInButton(
                                    _data,
                                        () async {

                                    },
                                  ),
                                ],
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
