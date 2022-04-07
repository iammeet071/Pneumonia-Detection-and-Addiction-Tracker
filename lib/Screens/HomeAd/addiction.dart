import 'package:flutter/material.dart';
import 'package:miniproject/Screens/HomeAd/homeAd.dart';
import 'package:miniproject/constants.dart';
import 'package:hexcolor/hexcolor.dart';

class Addiction extends StatefulWidget {
  const Addiction({Key? key}) : super(key: key);

  @override
  _AddictionState createState() => _AddictionState();
}

class _AddictionState extends State<Addiction> {
  
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height /2;
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                child: const Text('Go'))
          ]),
    );
  }
}
