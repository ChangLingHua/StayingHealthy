//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/vandf.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


//正確的


class EditInf extends StatefulWidget {
  DocumentSnapshot docid;
  EditInf({required this.docid}) ;

  //_controllerRemark = TextEditingController(text: _editItem['remark']);
  //_reference = FirebaseFirestore.instance.collection('user').doc(_editItem['id']);


  late DocumentReference _reference;


  //GlobalKey<FormState> _key = GlobalKey();


  /*Future cameraUpdate() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    print('${file?.path}');

    if(file == null) return;
    this._image = File(file.path);


    Reference referenceImageToUpload = FirebaseStorage.instance.refFromURL(_editItem['userImages']);

    try{

      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();

    }catch(error){
    };
  }*/

  @override
  State <EditInf> createState() => _EditInf();

}
class _EditInf extends State<EditInf> {

  TextEditingController _controllerRemark = TextEditingController();
  String url = '';

  @override
  void initState() {
    _controllerRemark = TextEditingController(text: widget.docid.get('remark'));
    url = widget.docid.get('userImages');
    super.initState();
  }

  String imageUrl = '';
  File? _image;

  /*Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null) {

      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

      print('${file?.path}');

      if(file == null) return;

    _controllerRemark.text = documentSnapshot['remark'];
    Reference referenceImageToUpload = FirebaseStorage.instance.refFromURL(documentSnapshot['userImages']);
    try{

      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        //this._image = File(file.path);
      });

    }catch(error){
    };
    }
  }*/

  Future cameraUpdate() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    print('${file?.path}');

    if(file == null) return;

    //final imageTemporary = File(file.path);
    /*setState(() {
      this._image = File(file.path);
    });*/


    Reference referenceImageToUpload = FirebaseStorage.instance.refFromURL(url);

    try{

      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();

      setState(() {
        Image.network(imageUrl);
      });

    }catch(error){
    };
  }

  Future galleryUpdate() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    print('${file?.path}');

    if(file == null) return;

    Reference referenceImageToUpload = FirebaseStorage.instance.refFromURL(url);

    try{

      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();

      setState(() {
        //this._image = File(file.path);
        Image.network(imageUrl);
      });

    }catch(error){
    };
  }

  imageSetState(){
    setState(() {
      //this._image = File(file.path);
      Image.network(url);
    });
  }

  Future delete() async{
    FirebaseStorage.instance.refFromURL(widget.docid.get('userImages')).delete();
    widget.docid.reference.delete();
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
        actions: [
          IconButton(
              onPressed: (){
                delete().whenComplete(() => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Vandf())));

              },
              icon: Icon(Icons.delete)),
        ],),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30,20,25,15),
        child: Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Form(
                //key: _key,
                child: Column(
                  children: [
                    Container(
                      height: 100,
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
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          label: Text('開啟相機', style: TextStyle(
                              fontSize: 18, color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen[600]
                          ),
                          icon: Icon(Icons.camera_alt),
                          onPressed: () async {
                            cameraUpdate();
                            //_update();
                          },

                        ),

                        SizedBox(width: 27,),

                        ElevatedButton.icon(
                          icon: Icon(Icons.photo),
                          onPressed: () {
                            galleryUpdate();
                          },
                          label: Text('選擇照片', style: TextStyle(
                              fontSize: 18, color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen[600]
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child:

                      imageSetState(),
                    ),
                    SizedBox(height: 80,),

                    ElevatedButton.icon(
                      label: Text(
                        '上傳', style: TextStyle(fontSize: 25, color: Colors
                          .white),),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen[600]
                      ),
                      icon: Icon(Icons.check),

                      onPressed: () async {
                        if (url == null) {
                          setState(() {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('請拍照！')));
                            return;
                          });
                        }
                        else {

                          /*DateTime now = DateTime.now();
                          String dateTime = DateFormat('yyyy-MM-dd HH:mm').format(now);*/

                          widget.docid.reference.update({
                            'remark': _controllerRemark.text,
                            'userImages': url,
                          }).whenComplete(() {
                            /*ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('上傳成功！')));*/
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) => Vandf()));
                          });
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
