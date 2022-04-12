// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jiffy/jiffy.dart';
import 'package:miniproject/Screens/Ads/AdPostForm.dart';
import 'package:miniproject/Screens/HomeAd/homeAd.dart';
import 'package:miniproject/Screens/config/palette.dart';
import 'package:miniproject/api/api.dart';
import 'package:miniproject/constants.dart';

final _formKey1 = GlobalKey<FormState>();
TextEditingController aid = TextEditingController();
TextEditingController title1 = TextEditingController();
TextEditingController body = TextEditingController();
Api api = Api();
DateTime days = DateTime.now();
int icount = 0;
var post1;
readPost(BuildContext context, Response info1) async {
  post1 = await json.decode(info1.body);
  print(info1);
  icount = json.decode(info1.body).length;
  print(post1);

  // finalday = DateTime.parse(info1[0]['startDate']);
  // print(finalday);
  // final1 = now.difference(finalday).inDays;
  print(final1);

  return post1;
}

class AdPosts extends StatefulWidget {
  const AdPosts({Key? key}) : super(key: key);

  @override
  State<AdPosts> createState() => _AdPostsState();
}

class _AdPostsState extends State<AdPosts> {
  @override
  Widget build(BuildContext context) {
    return icount != 0
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Text('Login'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formKey1,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  initialValue: null,
                                  controller: aid,
                                  decoration: const InputDecoration(
                                    labelText: 'Aid',
                                    icon: Icon(
                                      Icons.account_box,
                                    ),
                                  ),
                                  validator: (val) {
                                    if (aid.text == null || aid.text.isEmpty) {
                                      return 'Aid is empty';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                    controller: title1,
                                    decoration: const InputDecoration(
                                      labelText: 'Title',
                                      icon: Icon(Icons.email),
                                    ),
                                    validator: (val) {
                                      if (title1.text == null ||
                                          title1.text.isEmpty) {
                                        return 'Title is empty';
                                      }
                                      return null;
                                    }),
                                TextFormField(
                                  validator: (val) {
                                    if (body.text == null ||
                                        body.text.isEmpty) {
                                      return 'Body is empty';
                                    }
                                    return null;
                                  },
                                  controller: body,
                                  decoration: const InputDecoration(
                                    labelText: 'Body',
                                    icon: Icon(Icons.message),
                                  ),
                                ),
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
                                setState(() {
                                  if (_formKey1.currentState!.validate()) {
                                    api.createPost(context);
                                  }
                                });
                              })
                        ],
                      );
                    });
              },
              child: Icon(Icons.add),
              backgroundColor: kPrimaryColor,
            ),
            body: FutureBuilder(
                future: api.getAllPost(context),
                builder: ((BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: icount,
                          itemBuilder: ((BuildContext context, int index) {
                            return Card(
                                child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              title: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  snapshot.data[index]["title"].toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data[index]["body"],
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              trailing: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                    Jiffy(snapshot.data[index]['created'])
                                        .yMMMMd
                                        .toString(),
                                    style: TextStyle(fontSize: 16)),
                              ),
                            ));
                          }))
                      : const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                })),
          )
        : const Center(
            child: Text("No Post"),
          );
  }
}
