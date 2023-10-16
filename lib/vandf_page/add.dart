import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/vandf.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


// 使用 golbalKey

class Add extends StatelessWidget{
  Add({Key? key}) : super(key: key){
}

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: AddInf(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class AddInf extends StatefulWidget{
  const AddInf({Key? key}) : super(key: key);

  @override
  State <AddInf> createState() => _AddInf();
}

class _AddInf extends State<AddInf> {

  TextEditingController _controllerRemark = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  String imageUrl = '';
  File? _image;

  Future cameraUpload() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    print('${file?.path}');

    if(file == null) return;

    setState(() {
      this._image = File(file.path);
    });

    //設定時間格式
    DateTime now = DateTime.now();
    String dateTime = DateFormat('yyyy-MM-dd   HH:mm:ss').format(now);

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

    setState(() {
      this._image = File(file.path);
    });

    //設定時間格式
    DateTime now = DateTime.now();
    String dateTime = DateFormat('yyyy-MM-dd   HH:mm:ss').format(now);

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
        padding: EdgeInsets.all(8.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height ,
              child: Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controllerRemark,
                      decoration: InputDecoration(labelText: '備註'),
                      validator: (String? value){
                        if(value == null || value.isEmpty){
                          return null;
                        }
                        //return null;
                      },
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          label: Text('開啟相機',style: TextStyle(fontSize: 25,color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen[600]
                          ),
                          icon:Icon(Icons.camera_alt),
                          onPressed: () async{
                            cameraUpload();
                          },

                        ),

                        SizedBox(width: 10,),

                        ElevatedButton.icon(
                          label: Text('選擇照片',style: TextStyle(fontSize: 25,color: Colors.white),),
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
                    SizedBox(width: 80,),
                    Container(
                      width: 300,
                      height: 300,
                      child:
                      _image != null?
                      Image.file(_image!,width: 200,height: 200,fit: BoxFit.cover,)
                          : Image.asset('assets/food.jpeg'),
                    ),
                    SizedBox(width: 80,),
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
                                .showSnackBar(SnackBar(content:Text('請拍照！')));
                            return ;
                          });

                        }
                        else{

                          if(key.currentState!.validate()){
                            String remark = _controllerRemark.text;

                            DateTime now = DateTime.now();
                            String dateTime = DateFormat('yyyy-MM-dd   HH:mm:ss').format(now);

                            FirebaseFirestore.instance.collection('user').doc(dateTime).set(
                                {
                                  'time': dateTime,
                                  'remark': remark,
                                  'userImages': imageUrl,
                                });
                          }
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
    );
  }
}
