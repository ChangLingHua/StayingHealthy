import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/sedentary_page/music.dart';
import 'package:flutter_project/sedentary_page/remind.dart';
import 'package:flutter_project/sedentary_page/video.dart';



class Sedentary extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: const SedentaryState(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class SedentaryState extends StatefulWidget{
  const SedentaryState({Key? key}) : super(key: key);

  @override
  State<SedentaryState> createState() => _SedentaryState();

}

class _SedentaryState extends State<SedentaryState> {

  int index = 1;

  final screens = [
    Video(),
    Remind(),
    Music(),
  ];

  @override
  Widget build(BuildContext context) {

    final items = <Widget>[
      Icon(Icons.smart_display_outlined,size: 30,),
      Icon(Icons.timer,size: 30),
      Icon(Icons.music_note,size: 30,),
    ];

    return Container(
      color: Colors.orangeAccent,
      child: SafeArea(
        top: false,
        child: Scaffold(

          body:screens[index],

          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.black),
            ),
            child: CurvedNavigationBar(
              color: Colors.orangeAccent,
              backgroundColor: Colors.transparent,

              buttonBackgroundColor: Colors.orangeAccent[100],
              height: 55.0,
              index: index,
              items: items,
              onTap: (index) => setState(() => this.index = index),
            ),
          ),

        ),
      ),
    );



  }
}