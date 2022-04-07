// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:miniproject/Screens/config/palette.dart';
import 'package:miniproject/constants.dart';

class AdPosts extends StatelessWidget {
  const AdPosts({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(onPressed: (){

        }, child: const Text('Add Post',style: TextStyle(color: Colors.white),),color: kPrimaryColor,),
         Container(
            height: 500,
            child: ListView(         
          children: const <Widget>[
            Card(
            child: ListTile(
        
              contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('My Journey Begins',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),
              subtitle: Text('Here you can record things and give inputs about your day...',style: TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 2,),
              trailing: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Apr 14,2022",style: TextStyle(fontSize: 16)),
              ),
            ),
            
            ),
        
            Card(
            child: ListTile(
        
              contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('First Week !',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),
              subtitle: Text('Had an amazing week, More productive, Completed most of my work',style: TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 2,),
              trailing: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Apr 21,2022",style: TextStyle(fontSize: 16)),
              ),
            ),
            
            ),
          ],
        ),
          ),
        
      ],
    );
  }
}