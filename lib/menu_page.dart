import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'menu_items.dart';


class MenuItems {  // 新增 page

  static const home = Menuitem('首頁',Icons.home);
  static const vandf =  Menuitem('蔬果記錄',Icons.list_alt);
  static const sedentary = Menuitem('久坐提醒',Icons.airline_seat_recline_normal);


  static const all = <Menuitem>[

    home,
    vandf,
    sedentary,

  ];

}

class MenuPage extends StatelessWidget{

  final Menuitem currentItem;
  final ValueChanged<Menuitem> onSelectedItem;

   MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
   }) : super(key: key);
   
   
  @override
  Widget build(BuildContext context) => Theme(
    data: ThemeData.fallback(),
    child: Scaffold(
      backgroundColor: Colors.blueGrey,
      body:
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(flex: 2,),
            ...MenuItems.all.map(buildMenuItem).toList(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    ),

  );

  Widget buildMenuItem(Menuitem item) => ListTileTheme(
    child: ListTile(
      minLeadingWidth: 30,
      title: Text(item.title,style: TextStyle(fontSize: 22,color: Colors.black),),
      leading: Icon(item.icon,size: 30,color: Colors.black,),
      //selectedTileColor: Colors.black12,  // 點選框框
      selected: currentItem == item ,
      onTap: () => onSelectedItem(item),

    ),

  );

}



