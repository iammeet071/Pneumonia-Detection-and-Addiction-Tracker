import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/Screens/Ads/AdDetails.dart';
import 'package:miniproject/Screens/Ads/AdInfo.dart';
import 'package:miniproject/Screens/Ads/AdPosts.dart';
import 'package:miniproject/Screens/Ads/Adhome.dart';
import 'package:miniproject/Screens/Diet/selectdiet.dart';
import 'package:miniproject/Screens/HomeAd/addiction.dart';
import 'package:miniproject/Screens/HomeAd/homeAd.dart';
import 'package:miniproject/Screens/Predict/predict.dart';
import 'package:miniproject/constants.dart';



class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
  
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  
  int _selectedIndex = 0;
  int unit =1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
   Predict(),
    Addiction(),
    SelectDiet()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: Container(
        child: SingleChildScrollView(
          child: _widgetOptions.elementAt(_selectedIndex),
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Predict',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Adpost',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Diet',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
