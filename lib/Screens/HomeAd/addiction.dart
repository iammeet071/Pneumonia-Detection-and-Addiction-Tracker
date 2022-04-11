import 'package:flutter/material.dart';
import 'package:miniproject/Screens/HomeAd/homeAd.dart';
import 'package:miniproject/api/api.dart';
import 'package:miniproject/constants.dart';
import 'package:hexcolor/hexcolor.dart';

final _formKey = GlobalKey<FormState>();

class Addiction extends StatefulWidget {
  const Addiction({Key? key}) : super(key: key);
  @override
  @override
  _AddictionState createState() => _AddictionState();
}

class _AddictionState extends State<Addiction> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 2;
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height,
            ),
            const Text(
              "Addiction",
              style: TextStyle(fontSize: 21, color: kPrimaryColor),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                ),
                onPressed: () async {
                  setState(() {
                    Api().info(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  });
                },
                child: const Text('Go')),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: const Text('Login'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    initialValue: null,
                                    controller: title,
                                    // ignore: prefer_const_constructors
                                    decoration: InputDecoration(
                                      labelText: 'Title',
                                      icon: const Icon(
                                        Icons.account_box,
                                      ),
                                    ),
                                    validator: (val) {
                                      if (title.text == null ||
                                          title.text.isEmpty) {
                                        return 'Title is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                      controller: unit_price,
                                      decoration: const InputDecoration(
                                        labelText: 'Unit Price',
                                        icon: const Icon(Icons.email),
                                      ),
                                      validator: (val) {
                                        if (unit_price.text == null ||
                                            unit_price.text.isEmpty) {
                                          return 'Price is empty';
                                        }
                                        return null;
                                      }),
                                  TextFormField(
                                    validator: (val) {
                                      if (start.text == null ||
                                          start.text.isEmpty) {
                                        return 'Date is empty';
                                      }
                                      return null;
                                    },
                                    controller: start,
                                    decoration: const InputDecoration(
                                      labelText: 'Start Date',
                                      icon: Icon(Icons.message),
                                    ),
                                  ),
                                  TextFormField(
                                      controller: end,
                                      decoration: const InputDecoration(
                                        labelText: 'End Date',
                                        icon: Icon(Icons.message),
                                      ),
                                      validator: (val) {
                                        if (end.text == null ||
                                            end.text.isEmpty) {
                                          return 'Date is empty';
                                        }
                                        return null;
                                      }),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                                // ignore: prefer_const_constructors
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor),
                                child: const Text("Submit"),
                                onPressed: () async {
                                  // your code
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      // print(title.text);
                                      // print(unit_price.text);
                                      // print(start.text);
                                      // print(end.text);
                                      api.createAddiction(context);
                                      print("object1");
                                    }
                                  });
                                })
                          ],
                        );
                      });
                },
                child: const Text('Create'))
          ]),
    );
  }
}
