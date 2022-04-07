import 'package:flutter/material.dart';
import 'package:miniproject/Screens/Ads/Adhome.dart';
import 'package:miniproject/Screens/config/palette.dart';
import 'package:miniproject/Screens/Ads/AdDetails.dart';
import 'package:miniproject/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('Ronald Patrick'),
                accountEmail: const Text('ronald@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://avatars.githubusercontent.com/u/66828049?v=4',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.explore,
                  size: 30,
                ),
                title: const Text(
                  'Ad Details',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AdScreen()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_box,
                  size: 30,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        backgroundColor: Palette.secondary,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('Addiciton Tracker'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AdCard(
                title: 'Alcohol',
                day: 14,
                unit: 100,
              ),
              AdCard(
                title: 'Junk Food',
                day: 36,
                unit: 20,
              ),
              AdCard(
                title: 'Gaming',
                day: 2,
                unit: 40,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ));
  }
}

class AdCard extends StatelessWidget {
  String title;
  int day;
  int unit;
  AdCard({Key? key, required this.title, required this.day, required this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    unit = unit * day;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdDetails(
                      title: title,
                      unit: unit,
                      day: day,
                    )),
          );
        },
        child: Container(
          height: 200,
          width: double.infinity,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Palette.main),
                      ),
                      const Text(
                        'Money Saved',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹ ' + unit.toString(),
                        style: const TextStyle(
                            fontSize: 25, color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: day / 100,
                  center: Text(day.toString() + " days",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  progressColor: Palette.main,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
