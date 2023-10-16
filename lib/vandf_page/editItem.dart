//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/vandf.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// 使用 GlobalKey

class EditItem extends StatelessWidget{
  EditItem(this._item, {Key? key}) {

    _controllerRemark = TextEditingController(text: _item['remark']);


    _reference = FirebaseFirestore.instance
        .collection('user')
        .doc(_item['id']);

  }

  Map _item;
  String imageUrl = '';
  File? _image;

  late DocumentReference _reference;

  late TextEditingController _controllerRemark;


  GlobalKey<FormState> key = GlobalKey();

  Future cameraUpdate() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    print('${file?.path}');

    if(file == null) return;
    this._image = File(file.path);

    Reference referenceImageToUpload = FirebaseStorage.instance.refFromURL(_item['userImages']);

    try{

      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();


    }catch(error){
    };
  }

  Future galleryUpdate() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    print('${file?.path}');

    if(file == null) return;
    this._image = File(file.path);

    Reference referenceImageToUpload = FirebaseStorage.instance.refFromURL(_item['userImages']);

    try{

      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();


    }catch(error){
    };
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('編輯', style: TextStyle(color: Colors.white),),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Vandf()));
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
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child:
              Form(
                key: key,
                child:Column(
                  children: [
                    SizedBox(height: 15,),
                    TextField(
                      controller: _controllerRemark,
                      decoration: InputDecoration(
                        labelText: '備註',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                      ),
                      /* validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          return null;
                        },*/
                      onChanged: (String){
                        //newRemark = _controllerRemark.text;
                      },
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          label: Text('開啟相機', style: TextStyle(
                              fontSize: 25, color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen[600]
                          ),
                          icon: Icon(Icons.camera_alt),
                          onPressed: () async {
                            cameraUpdate();
                          },

                        ),

                        SizedBox(width: 10,),

                        ElevatedButton.icon(
                          label: Text('選擇照片', style: TextStyle(
                              fontSize: 25, color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen[600]
                          ),
                          icon: Icon(Icons.photo),
                          onPressed: () {
                            galleryUpdate();
                          },
                        ),
                      ],
                    ),
                    SizedBox(width: 80,),
                    SizedBox(width: 80,),
                    ElevatedButton.icon(
                      label: Text('上傳', style: TextStyle(fontSize: 25, color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen[600]
                      ),

                      icon: Icon(Icons.check),

                      onPressed: () async {
                        if (_image == null) {

                          /*ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('請拍照或上傳圖片！')));*/
                          return;
                        }
                        else {
                          if (key.currentState!.validate()) {
                            //String remark = _controllerRemark.text;
                            DateTime now = DateTime.now();
                            String dateTime = DateFormat('yyyy-MM-dd  HH:mm:ss')
                                .format(now);

                          /*  Map<String, String> dataToUpdate = {
                              'time': dateTime,
                              'remark': _controllerRemark.text,
                              'userImages': imageUrl,
                            };
                            _reference.update(dataToUpdate);*/

                            FirebaseFirestore.instance.collection('user')
                                .doc(dateTime).update(
                                {
                                  'time': dateTime,
                                  'remark': _controllerRemark.text,
                                  'userImages': imageUrl,
                                });
                          }

                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('上傳成功！')));
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Vandf()));
                          _controllerRemark.clear();
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

