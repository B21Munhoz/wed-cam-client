import 'package:flutter/material.dart';
import 'package:wed_cam_client/ui/utils/others.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';
import 'package:wed_cam_client/ui/utils/dialogs.dart';
import 'package:wed_cam_client/api/base_request.dart';



class CreateEvent extends StatefulWidget {
  final token;

  CreateEvent({
    Key ?key,
    @required this.token,
  }) : super(key: key);

  @override
  CreateEventState createState() => CreateEventState(
    token: token, key: key);
}

class _CreateEventData {
  String name = "";
  bool _validateSerialKey = false;
}

class CreateEventState extends State<CreateEvent> {
  final token;

  CreateEventState({
    Key ?key,
    @required this.token,
  });

  final _formKey = GlobalKey<FormState>();

  _CreateEventData _data = _CreateEventData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar("Agendando Seu Casamento",[]),
      body: Container(
        color: Colors.grey.shade300,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Card(
              child: ListView(
                children: <Widget>[
                  //NAME

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      cursorColor: _data._validateSerialKey ? Colors.red : textPink,
                      style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600,
                        color: textPink),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 16),
                        labelText: "Nome do Casamento",
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
                      initialValue: "",
                      validator: (value) {
                        if (value!.isEmpty) {
                          _data._validateSerialKey = true;
                          setState(() {});
                          return "Dê um nome para o casamento";
                        } else {
                          _data._validateSerialKey = false;
                          _data.name = value;
                          setState(() {});
                          return null;
                        }
                      },
                    ),
                  ),

                  //BOTÕES
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // BOTÃO CANCELAR
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: RaisedButton(
                            elevation: 6,
                            onPressed: () {
                              _data._validateSerialKey = false;
                              setState(() {});
                              _formKey.currentState!.reset();
                              Navigator.pop(context,  true);
                            },
                            color: Colors.red,
                            child: Icon(Icons.clear),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: RaisedButton(
                            elevation: 6,
                            onPressed: () async {
//                              _validatePassError = false;
//                              _validateUserError = false;
                              if (_formKey.currentState!.validate()) {
                                try {
                                  var url = Uri.http(baseUrl,'api/create_event');
                                  var response = await fetchPost(
                                    {"name": "${_data.name}"},
                                    token, url, context,
                                  );
                                  if ((response.statusCode == 200) || (response.statusCode == 202)
                                      || (response.statusCode == 201) || (response.statusCode == 204)
                                      || (response.statusCode == 203)){
                                    mySuccessConfirmDialog(
                                      context,
                                      "Casório Criado!",
                                      true,
                                    );

                                  } else if (response.statusCode == 400){
                                    myErrorConfirmDialog(
                                      context,
                                      "Desculpe, houve um problema.",
                                    );
                                  } else if (response.statusCode == 401){
                                    myErrorConfirmDialog(
                                      context,
                                      "Operação não autorizada!",
                                    );
                                  } else {
                                    myErrorConfirmDialog(
                                      context,
                                      "Desculpe. Encontramos um problema.",
                                    );
                                  }
                                } catch (e){
                                  myErrorConfirmDialog(
                                    context,
                                    e.toString(),
                                  );
                                }
                                finally {
//                          client.close();
                                }
                              }
                            },
                            color: Colors.green,
                            child: Icon(Icons.check),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: whatsAppButton(profile.name),
    );
  }
}
