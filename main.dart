import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/home.dart';
import 'package:flutter_project/menu_items.dart';
import 'package:flutter_project/menu_page.dart';
import 'package:flutter_project/sedentary.dart';
import 'package:flutter_project/vandf.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Menuitem currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) => ZoomDrawer(
      style: DrawerStyle.defaultStyle ,
      borderRadius: 40,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.6,
      showShadow: true,

      menuBackgroundColor: Colors.blueGrey,
      drawerShadowsBackgroundColor: Colors.white,

      mainScreen: getScreen(),
      menuScreen: Builder(
        builder: (context) => MenuPage(
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() => currentItem = item);
            ZoomDrawer.of(context)!.close();
          },
        ),
      ),

  );



  Widget getScreen() {  // page 選擇

      switch (currentItem){

        case MenuItems.home:
          return Home();
        case MenuItems.vandf:
          return Vandf();
        default:
          return Sedentary();
      }
  }
}
