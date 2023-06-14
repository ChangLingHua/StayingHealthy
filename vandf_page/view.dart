//import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_project/vandf_page/addItem.dart';
import 'package:flutter_project/vandf_page/detail.dart';
import 'package:flutter_project/vandf_page/edit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../menu_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'add.dart';


class View extends StatefulWidget{
  View({Key? key}) : super(key: key);

  @override
  State <View> createState() => _View();

}

final _reference = FirebaseFirestore.instance.collection('user').orderBy('time', descending: true);

class _View extends State<View>{

  final Stream<QuerySnapshot> user = _reference.snapshots();



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('蔬果記錄',style: TextStyle(color: Colors.white),),
        leading: MenuWidget(),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: user,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if(snapshot.hasData){

            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> item = documents.map((e) => {
              'id':e.id,
              /*'time':e['time'],
              'remark':e['remark'],
              'image':e['userImages']*/
            }).toList();
            List<Map> items = documents.map((e) => e.data() as Map).toList();


            return ListView.builder(
                itemCount: snapshot.data!.docs.length,  //items.length,
                itemBuilder: (BuildContext context, int index){

                  return InkWell(
                    child: Container(
                      height: 150,
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        color: Colors.yellow,
                        child: Row(

                          children: [
                            Container(
                              width: 150,
                              height: 130,
                              child: Card(
                                color: Colors.amberAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.fromLTRB(8, 10, 3, 10),
                                elevation: 0,
                                child: ClipRRect(
                                  borderRadius : BorderRadius.circular(20),
                                  child: Image.network(
                                      '${snapshot.data!.docChanges[index].doc['userImages']}',width: 110, height: 110,fit: BoxFit.cover) ,
                                ),
                              ),
                            ),


                            Container(
                              margin: EdgeInsets.fromLTRB(5, 25, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('時間：'+ snapshot.data!.docChanges[index].doc['time'],style: TextStyle(fontSize: 18),),
                                  SizedBox(height: 10,),
                                  Text.rich(
                                    TextSpan(text: '備註：',style: TextStyle(fontSize: 18),
                                      children: [
                                        TextSpan(
                                          text:snapshot.data!.docChanges[index].doc['remark'],style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        /*Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Detail(thisItem['id'])));*/
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EditInf(docid: snapshot.data!.docs[index]),
                          ),
                        );
                      });
                    },
                  );
                });
          };

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddItem()));
        },
        tooltip: '新增',
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }
}



