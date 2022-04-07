import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniproject/Screens/Login/components/body.dart';
import 'package:miniproject/Screens/Predict/components/predict_body.dart';
import 'package:miniproject/Screens/Signup/components/body.dart';
import 'package:miniproject/home.dart';
import 'package:miniproject/main.dart';
import 'package:miniproject/storage/storage.dart';

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
    resultS = jsonDecode(responseSup.body)["status"];
    print(resultS);
    if (resultS == "Created") {
      print("objec 1nout");

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

  Future<void> imgUpload(
      BuildContext context, String string, File? image) async {
    var strings = string;
    print(image);
    // File? img = image;

    print(strings);
    var token = await secureStorage.readSecureData("token");
    // var resimg = await http.post(Uri.parse("$baseUrl/imgupload"),
    //     headers: ({"Authorization": "token $token"}),
    //     body: ({"Xray": "$image"}));
    var headers = {
      'content-type': 'multipart/form-data',
      'Accept': 'application/json',
      "Authorization": "token $token"
    };

    //setup request
    var resimg = http.MultipartRequest("POST", Uri.parse("$baseUrl/imgupload"));

    //add files to reqest body
    resimg.files.add(await http.MultipartFile.fromPath(
      'Xray',
      image!.path,
    ));

    //add header
    resimg.headers.addAll(headers);
    print(resimg.files);
    try {
      var streamedResponse = await resimg.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      var resp = jsonDecode(response.body)["status"];
      if (resp == "success") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color.fromARGB(255, 54, 244, 54),
            content: Text(
              jsonDecode(response.body)["result"],
              style: TextStyle(fontSize: 15),
            )));
      }
    } catch (e) {
      rethrow;
    }
  }
}
