import 'package:flutter/material.dart';
import 'package:wed_cam_client/business_logic/login_data.dart';
import 'package:wed_cam_client/ui/utils/my_palett.dart';


Widget userFormField(LoginData data){
  Padding p = new Padding(
    padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
    child: SizedBox(
      width: 325,
      child: TextFormField(
        cursorColor: data.validateUserError
            ? errorRed
            : textPink,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600,
            color: textPink),
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 16),
          labelText: "Usuário",
          labelStyle: TextStyle(color: textPink),
          prefixIcon: Icon(
            Icons.account_circle,
            color: data.validateUserError
                ? errorRed
                : textPink,
          ),
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
        initialValue: data.username,
        validator: (value) {
          if (value!.isEmpty) {
            data.validateUserError = true;
            return "Insira seu nome de usuário";
          } else {
            data.validateUserError = false;
            data.username = value;
            return null;
          }
        },
      ),
    ),
  );
  return p;
}

Widget passwordFormField(LoginData data, VoidCallback onPressedFunction){
  Padding p = new Padding(
    padding: const EdgeInsets.all(8),
    child: SizedBox(
      width: 325,
      child: TextFormField(
        cursorColor: data.validateUserError
            ? errorRed
            : textPink,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600,
            color: textPink),
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 16),
          labelText: "Senha",
          labelStyle: TextStyle(color: textPink),
          prefixIcon: Icon(
              Icons.vpn_key,
              color: data.validatePassError
                  ? errorRed
                  : textPink),
          suffixIcon: IconButton(
              icon: Icon(data.passwordVisible
                  ? Icons.visibility_off
                  : Icons.visibility),
              color: data.validatePassError
                  ? errorRed
                  : textPink,
              onPressed: onPressedFunction,
              ),
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
        initialValue: "${data.password}",
        obscureText: data.passwordVisible ? true : false,
        validator: (value) {
          if (value!.isEmpty) {
            data.validatePassError = true;
            return "Insira sua senha";
          } else {
            data.validatePassError = false;
            data.password = value;
            return null;
          }
        },
      ),
    ),
  );
  return p;
}

Widget signUpButton(LoginData data, VoidCallback onPressedFunction){
  Padding p = new Padding(
    padding: const EdgeInsets.all(8),
    child: ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        primary: goldenYellow, // background
        onPrimary: Colors.white,
        elevation: 5,// foreground
      ),
      child: Text("CADASTRAR"),
    ),
  );
  return p;
}

Widget signInButton(LoginData data, VoidCallback onPressedFunction){
  Padding p = new Padding(
    padding: const EdgeInsets.all(8),
    child: ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        primary: textPink, // background
        onPrimary: Colors.white,
        elevation: 5,// foreground
      ),
      child: Text("ENTRAR"),
    ),
  );
  return p;
}