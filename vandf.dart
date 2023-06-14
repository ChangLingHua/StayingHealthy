import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/vandf_page/fruits.dart';
import 'package:flutter_project/vandf_page/vegetables.dart';
import 'package:flutter_project/vandf_page/view.dart';


class Vandf extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: const VF(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class VF extends StatefulWidget{
  const VF({Key? key}) : super(key: key);

  @override
  State<VF> createState() => _VF();

}

class _VF extends State<VF> {

  int index = 1;

  final screens = [
    Vegetables(),
    View(),
    Fruits(),
  ];

  @override
  Widget build(BuildContext context) {

    final items = <Widget>[
      Icon(Icons.grass,size: 30),
      Icon(Icons.list_alt,size: 30,),
      Icon(Icons.apple,size: 30,),

    ];

    return Container(
      color: Colors.green,
      child: SafeArea(
        top: false,
        child: Scaffold(

          body:screens[index],

          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.black),
            ),
            child: CurvedNavigationBar(
              color: Colors.green,
              backgroundColor: Colors.transparent,

              buttonBackgroundColor: Colors.lightGreen[300],
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
