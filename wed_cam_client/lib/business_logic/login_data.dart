import 'package:shared_preferences/shared_preferences.dart';

class LoginData {
  String username = "";
  String password = "";
  String token = "";
  bool gotValue = false;
  bool validateUserError = false;
  bool validatePassError = false;
  bool passwordVisible = true;
  //SharedPreferences prefs = SharedPreferences();

  setLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uname', username);
    await prefs.setString('pass', password);
  }

  getLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('uname')) {
      username = prefs.getString('uname')!;
    } else {
      username = "";
    }
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('pass')) {
      password = prefs.getString('pass')!;
    } else {
      password = "";
    }
    gotValue = true;
  }

  LoginData() {
    getLoginInfo();
  }

}

