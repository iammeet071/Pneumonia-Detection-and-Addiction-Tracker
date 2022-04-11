// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniproject/Screens/HomeAd/homeAd.dart';
import 'package:miniproject/Screens/Login/components/body.dart';
import 'package:miniproject/Screens/Predict/components/predict_body.dart';
import 'package:miniproject/Screens/Signup/components/body.dart';
import 'package:miniproject/home.dart';
import 'package:miniproject/main.dart';
import 'package:miniproject/storage/storage.dart';

var responseLogin, result, responseSup, loggedValue, resultS;
var baseUrl = "http://health-companion-22.herokuapp.com";

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
      var tk = jsonDecode(responseSup.body)["token"];
      print(jsonDecode(responseSup.body)["token"]);
      secureStorage.writeSecureData("token", tk);
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

  Future<void> createAddiction(BuildContext context) async {
    var token1 = await secureStorage.readSecureData("token");
    print("objectabc");
    print(token1);
    print("objectabcd");
    var createAd = await http.post(Uri.parse("$baseUrl/createAddiction"),
        headers: ({
          'Accept': 'application/json',
          "Authorization": "token $token1"
        }),
        body: ({
          "title": title.text,
          "unit_price": unit_price.text,
          "startDate": start.text,
          "endDate": end.text
        }));
    //setup request
    print("title");
    print(title.text);
    print(createAd.body);
    if (jsonDecode(createAd.body)["aid"] != null) {
      Navigator.push(context, MaterialPageRoute(builder: ((context) {
        return Home();
      })));
    }

    //add header
  }

  Future<List> info(BuildContext context) async {
    var tokeninfo = await secureStorage.readSecureData("token");
    print(tokeninfo);
    var info = await http.get(Uri.parse("$baseUrl/info"),
        headers: ({
          'Accept': 'application/json',
          "Authorization": "token $tokeninfo"
        }));
    //setup request
    print(title.text);
    var stores = json.decode(info.body);
    final length = stores.length;
    print(length);
    print(stores);

    if (length != 0) {
      info.toString();
      read(context, info);
    }
    return stores;

    //add header
  }

  Future<int> getLenght(BuildContext context) async {
    var xyz = await info(context);
    return xyz.length;
  }
}
