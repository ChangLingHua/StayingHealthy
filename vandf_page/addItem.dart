import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/vandf.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class AddItem extends StatelessWidget{
  AddItem({Key? key}) : super(key: key){
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: AddItemInf(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class AddItemInf extends StatefulWidget{
  const AddItemInf({Key? key}) : super(key: key);

  @override
  State <AddItemInf> createState() => _AddItemInf();
}

class _AddItemInf extends State<AddItemInf> {

  TextEditingController _controllerRemark = TextEditingController();

  CollectionReference _reference = FirebaseFirestore.instance.collection('user');

  String imageUrl = '';
  File? _image;

  Future cameraUpload() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    print('${file?.path}');

    if(file == null) return;


    //設定時間格式
    DateTime now = DateTime.now();
    String dateTime = DateFormat('yyyy-MM-dd   HH:mm').format(now);

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('userImages');
    Reference referenceImageToUpload = referenceDirImage.child(dateTime);

    if(file.path != null){

    }
    try{

      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        this._image = File(file.path);
      });

    }catch(error){
    };
  }

  Future galleryUpload() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    print('${file?.path}');

    if(file == null) return;

    //設定時間格式
    DateTime now = DateTime.now();
    String dateTime = DateFormat('yyyy-MM-dd   HH:mm').format(now);

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('userImages');
    Reference referenceImageToUpload = referenceDirImage.child(dateTime);

    try{

      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        this._image = File(file.path);
      });

    }catch(error){
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('新增',style: TextStyle(color: Colors.white),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Vandf()));
                });
              },
              tooltip: '上一頁',
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30,20,25,15),
        child: Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height ,
              child: Form(
                //key: key,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _controllerRemark,
                        decoration: const InputDecoration(
                          labelText: '備註',
                          labelStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black
                          ),
                          enabledBorder: OutlineInputBorder(
                            ///設定邊框四個角的弧度
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            ///用來配置邊框的樣式
                            borderSide: BorderSide(
                              ///設定邊框的顏色
                              color: Colors.green,
                              ///設定邊框的粗細
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            ///設定邊框四個角的弧度
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            ///用來配置邊框的樣式
                            borderSide: BorderSide(
                              ///設定邊框的顏色
                              color: Colors.green,
                              ///設定邊框的粗細
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          label: Text('開啟相機',style: TextStyle(fontSize: 18,color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen[600]
                          ),
                          icon:Icon(Icons.camera_alt),
                          onPressed: () async{
                            cameraUpload();
                          },

                        ),

                        SizedBox(width: 30,),

                        ElevatedButton.icon(
                          label: Text('選擇照片',style: TextStyle(fontSize: 18,color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen[600]
                          ),
                          icon:Icon(Icons.photo),
                          onPressed: () async{
                            galleryUpload();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Container(
                      width: 350,
                      height: 350,
                      child:
                      _image != null?
                      Image.file(_image!,width: 200,height: 200,fit: BoxFit.cover,)
                          : Image.asset('assets/food.jpeg'),
                    ),
                    SizedBox(height: 18,),
                    ElevatedButton.icon(
                      label: Text('上傳',style: TextStyle(fontSize: 25,color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen[600]
                      ),
                      icon:Icon(Icons.check),

                      onPressed: () async {
                        if(_image == null){
                          setState(() {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content:Text('請拍照或選擇照片！')));
                            return ;
                          });

                        }
                        else{
                          DateTime now = DateTime.now();
                          String dateTime = DateFormat('yyyy-MM-dd   HH:mm').format(now);

                          _reference.doc(dateTime).set({
                            'time':dateTime,
                            'remark':_controllerRemark.text,
                            'userImages':imageUrl,
                          });

                          
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content:Text('上傳成功！')));
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Vandf()));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),


      //floatingActionButton: _FAB(),

    );

  }
}