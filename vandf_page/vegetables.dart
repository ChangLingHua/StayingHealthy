
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/menu_widget.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Vegetables());
}

class Vegetables extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Veg(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class Veg extends StatefulWidget {
  const Veg({Key? key}) : super(key: key);

  @override
  State <Veg> createState() => _Veg();

}

class _Veg extends State<Veg>{

  final Stream<QuerySnapshot> vegetable =
  FirebaseFirestore.instance.collection('vegetables').snapshots();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 240) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[600],
        title: Text('蔬菜熱量'),
        leading: MenuWidget(),
      ),
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 100,

              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(13, 6, 8, 5),
                      child: Icon(Icons.campaign,size: 27,),
                    ),
                    Container(

                      margin: EdgeInsets.fromLTRB(12, 10, 8, 10),
                      child: Text.rich(
                        TextSpan(text: '建議每天應攝取至少 ',style: TextStyle(color: Colors.black,fontSize: 16),
                          children: [
                            TextSpan(text: ' 3 份蔬菜\n',style: TextStyle(color: Colors.redAccent,fontSize: 20)),
                            TextSpan(text: '(蔬菜煮熟後約一碗半或300公克)',style: TextStyle(color: Colors.black,fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(6, 10, 10, 10),
                      child: IconButton(
                        icon: Icon(Icons.tips_and_updates,color: Colors.orangeAccent,size: 30,),
                        onPressed: _showDialogButton,
                        ),
                        ),
                  ],
                ),
              ),
            ),


            Container(
              height: 440,
              child: StreamBuilder<QuerySnapshot>(
                stream: vegetable,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.hasError){
                    return Container(
                      alignment: Alignment.center,
                      child: Text('wrong'),
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Container(
                      alignment: Alignment.center,
                      child: Text('loading...'),
                    );
                  }

                  final data = snapshot.requireData;

                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                      ),
                      itemCount: data.size,
                      itemBuilder: (BuildContext context, index){
                        return Card(
                          color: Colors.lightBlue[50],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          clipBehavior: Clip.antiAlias,
                          elevation: 3,
                          margin: EdgeInsets.fromLTRB(6, 6, 10, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network('${data.docs[index]['url']}',
                                fit: BoxFit.fill,
                                width: 100,height: 100,),

                              Text('${data.docs[index]['name']}',
                                style: TextStyle(fontSize: 23),),

                              SizedBox(height: 5.0,),

                              Text('${data.docs[index]['kcal']} / 100g',
                                style: TextStyle(color: Colors.black54,fontSize: 15),),

                              SizedBox(height: 5.0,),
                            ],
                          ),
                        );
                      });
                },
              ),
            ),

          ],

        ),
      ),


    );
  }

  _showDialogButton() => showDialog<String>(
      context: context,
      builder: (BuildContext context){
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height - 60,
          child: AlertDialog(
            title: Row(
              children: [
                Icon(Icons.trending_up,color: Colors.green,size: 25,),
                //Spacer(),
                Text('  小秘訣'),
              ],
            ),
            content:
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height ,
                  child: Text.rich(
                    TextSpan(text: '購買：\n',style: TextStyle(fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: '＞ 購買當季、當地的新鮮蔬果，營養好、價格低又環保。 \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(text: '＞ 儲存一些乾燥或冷凍蔬菜在冰箱，作為新鮮蔬果不足時的備用品。  \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),

                          TextSpan(text: '\n處理與烹調： \n',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '＞ 搭配五顏六色青菜水果，提升食慾，又可獲得多重保健效果。  \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(text: '＞ 蔬果購回，處理後分成小包儲存，減少小量製作的不便。 \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),

                          TextSpan(text: '\n食用： \n',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '＞ 吃新鮮蔬菜水果，比榨蔬果汁保留了更多的纖維。 \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(text: '＞ 用新鮮蔬菜水果或自製蔬果點心取代高熱量零食點心。 \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(text: '＞ 上班族自帶蔬菜水果，時時「加菜」。 \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(text: '＞ 每餐都要盤點是否吃到蔬菜水果，包括早餐。 \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(text: '＞ 便當盒、自助餐盤留固定空間或空格裝滿青菜。 \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),
                          TextSpan(text: '\n資料來源：衛生福利部 \n',
                              style: TextStyle(fontWeight: FontWeight.normal)),

                        ]
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
}

