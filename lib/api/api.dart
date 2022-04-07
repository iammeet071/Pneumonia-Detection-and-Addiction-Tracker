import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniproject/Authentication/register.dart';
import 'package:miniproject/Screens/HomeAd/homeAd.dart';
import 'package:miniproject/Screens/Login/components/body.dart';
import 'package:miniproject/Screens/Predict/predict.dart';
import 'package:miniproject/Screens/Signup/components/body.dart';
import 'package:miniproject/home.dart';
import 'package:miniproject/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var responseLogin, result, responseSup, loggedValue, resultS;
var baseUrl = "https://health-companion-22.herokuapp.com";

class Api {
  final SecureStorage secureStorage = SecureStorage();
  Future<void> login(BuildContext context) async {
    responseLogin = await http.post(Uri.parse("$baseUrl/login"),
        body: ({
          "username": userController.text,
          "password": passController.text
        }));
    print(responseLogin.statusCode);
    print(responseLogin.statusCode);
    print(userController.text);
    result = jsonDecode(responseLogin.body)["token"];
    if (result != null) {
      print(responseLogin.body);
      print(jsonDecode(responseLogin.body)["token"]);
      secureStorage.writeSecureData("token", result);
      // var abc =await secureStorage.readSecureData("token");
      // print(abc);
      // print("abc");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
      );
    } else {
      print(responseLogin.body);
      print(
        jsonDecode(responseLogin.body)["payload"],
      );
      print(jsonDecode(responseLogin.body)["status"]);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            jsonDecode(responseLogin.body)["payload"],
            style: TextStyle(fontSize: 15),
          )));
    }
  }

  Future<void> signUp(BuildContext context) async {
    responseSup = await http.post(Uri.parse("$baseUrl/register"),
        body: ({
          "username": userSignUpController.text,
          "email": emailSignUpController.text,
          "password": passSignUpController.text
        }));
    print(responseSup.body);
    print(userSignUpController.text);
    print(emailSignUpController.text);
    print(passSignUpController.text);

    print("objec out");
    if (responseSup.statusCode == 200) {
      print("objec 1nout");
      resultS = jsonDecode(responseSup.body)["token"];
      print(jsonDecode(responseSup.body)["token"]);
      secureStorage.writeSecureData("token", resultS);
      print(responseSup.body);
      print(jsonDecode(responseSup.body)["token"]);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyStatefulWidget()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "something went Wrong",
            style: TextStyle(fontSize: 15),
          )));
    }
  }
}
