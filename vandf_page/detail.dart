//import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/vandf_page/editItem.dart';

class Detail extends StatelessWidget {

  Detail(this.itemId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('user').doc(itemId);

    _futureData = _reference.get();

  }

  String itemId;
  late DocumentReference _reference;
  late Reference referenceImage;

  Future imageDelete() async{
    if(itemId != null){
      referenceImage = FirebaseStorage.instance.refFromURL(data['userImages']) ;
      referenceImage.delete();
    }
  }

  late Future<DocumentSnapshot> _futureData;
  late Map data;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('詳細資訊'),
      actions: [
        IconButton(
            onPressed: (){
              data['id'] = itemId;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditItem(data)));

            },
            icon: Icon(Icons.edit)),
        IconButton(
            onPressed: (){
              _reference.delete();
              imageDelete();
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete)),
      ],),
      body:
      FutureBuilder<DocumentSnapshot>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }
          if(snapshot.hasData){
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;

            return Center(
              child: Card(
                //color: Colors.green[400],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  /*side: BorderSide(
                    color: Colors.black,
                    //width: 3
                  ),*/
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                  height: 500,
                  width: 400,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Padding(padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Text.rich(
                                TextSpan(text:'時間 ：',style: TextStyle(fontSize: 23,color: Colors.red),
                                    children: [
                                      TextSpan(text: '${data['time']}',style: TextStyle(color: Colors.blueAccent)),
                                    ])
                            ),

                            SizedBox(height: 15,),

                            Text.rich(
                              TextSpan(text:'備註 ：',style: TextStyle(fontSize: 20,color: Colors.red),
                                  children: [
                                    TextSpan(text: '${data['remark']}',style: TextStyle(color: Colors.blueAccent)),
                                  ]),

                            ),

                            SizedBox(height: 20,),

                            Image.network('${data['userImages']}',width: 300,height: 300,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      

    );
  }
  }