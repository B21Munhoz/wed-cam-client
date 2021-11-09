import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:wed_cam_client/ui/login/login.dart';


void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool isSafari = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink.shade300,
        errorColor: Colors.red,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pink.shade300,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      title: "WeddingCam",
      home:
      CustomLoginForm(isWeb: UniversalPlatform.isWeb, ),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => new CustomLoginForm(isWeb: UniversalPlatform.isWeb, )
      },
//      CustomLoginForm(isWeb: true),
    );
  }
}
