 import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application/components/reusable_components.dart';
import 'package:news_application/layout/news_layout.dart';

class splashScreen extends StatefulWidget
{
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  void initState(){
    super.initState();

    Timer(Duration(seconds: 3), ()=>Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=> NewsLayout()
        )));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepOrangeAccent,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/Images/download.jpg'),
              ),
              SizedBox(height: 15,),
              Text('News app',)
            ],
          ),
        ),
      ),
    );
  }
}