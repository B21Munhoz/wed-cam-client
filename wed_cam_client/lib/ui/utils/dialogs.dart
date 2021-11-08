import 'package:flutter/material.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';


Widget myLoading(){
  Container c = new Container(
      color: Colors.white,
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: new Text(
          "Carregando...",
          style: TextStyle(
              color: textPink,
              fontWeight: FontWeight.w800,
              fontSize: 20),
          textAlign: TextAlign.center,
        ),
        title: Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(color: textPink,),
            )),
      ));
  return c;
}

Widget loginEnterDialog(){
  AlertDialog a = new AlertDialog(
    backgroundColor: Colors.white,
    content: new Text(
      "Entrando...",
      style: TextStyle(
          color: textPink,
          fontWeight: FontWeight.w800,
          fontSize: 20),
      textAlign: TextAlign.center,
    ),
    title: Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(color: textPink,),
        )),
  );
  return a;
}

String loginErrorAuthContext = "Usuário ou senha incorretos!";
String loginErrorInternalContext = "Desculpe, um erro inesperado ocorreu.";
String loginErrorConnect = "Não foi possível comunicar com o servidor.";
void myErrorConfirmDialog(context, content) {
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
              content,
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

String kitPutSuccess = "Cultivo atualizado com sucesso!";
String doserPutSuccess = "Parâmetros ajustados com sucesso!";
String signUpSucces = "Usuário criado com sucesso!";

void mySuccessConfirmDialog(context, content, pop) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: new Text(
              "SUCESSO",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            content: new Text(
              content,
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              new FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8),
                  splashColor: Colors.greenAccent,
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (pop) Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 20),
                  ))
            ]);
      });
}


void myInfoConfirmDialog(context, content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: new Text(
              "INFORMAÇÃO",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            content: new Text(
              content,
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              new FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8),
                  splashColor: Colors.blue,
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

void mySuccessConfirmDialogNoPop(context, content) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: new Text(
              "SUCESSO",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w800,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            content: new Text(
              content,
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              new FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8),
                  splashColor: Colors.greenAccent,
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