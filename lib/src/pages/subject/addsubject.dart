import 'dart:io';  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';

class AddSubjectPage extends StatefulWidget {
  @override
  _AddSubjectPageState createState() => _AddSubjectPageState();
}

class _AddSubjectPageState extends State<AddSubjectPage> {

  TextEditingController subName = TextEditingController();
  TextEditingController subCode = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _image;
  File file;
  String postId = Uuid().v4(); 


  @override
  void dispose(){
    super.dispose();
    subName.dispose();
    subCode.dispose();
  }

  uploadFile(imageFile) async{
    StorageUploadTask uploadTask = FirebaseStorage.instance.ref().child('subject_pic/${Path.basename(_image.path)}')
      .putFile(imageFile);
      StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
      String downloadUrl = await storageSnap.ref.getDownloadURL();
      return downloadUrl;
  }

  Future getImage() async {
   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {    
     setState(() {    
       _image = image;    
     });    
   });    
  }

  compressImage() async{
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(_image.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')..writeAsBytesSync(Im.encodeJpg(imageFile,quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  createSubject() async {
    await compressImage();
    String url = await uploadFile(file);
    Firestore.instance.collection('Subjects').document(postId).setData({
       "code": int.parse(subCode.text),
        "name": subName.text,
        "image": url,
        "uid": postId
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('กำลังบันทึกข้อมูล วิชา ${subName.text}')));
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pop(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('เพิ่มรายวิชา'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image != null
              ? Container(
                height: 200.0,
                width: 200.0,
                margin: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(_image)
                  )
                ),
              )
              : Container(
                height: 200.0,
                width: 200.0,
                margin: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/icon/picture.png')
                  )
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: getImage,
                child: Text('แก้ไขรูปภาพวิชา',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent)),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: new Text(
                        'ชื่อวิชา',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          fontFamily: 'Sukhumvit'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        textAlign: TextAlign.left,
                        controller: subName,
                        style: TextStyle(
                          fontFamily: 'Sukhumvit'
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: new Text(
                        'รหัสวิชา',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          fontFamily: 'Sukhumvit'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 20.0, right: 40.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextField(
                        controller: subCode,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Sukhumvit'
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: createSubject,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(0.0),
                  side: BorderSide(color: Colors.blueAccent)
                ),
                child: Text('เพิ่มรายวิชา',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
              )
            ]
          )
        ],
      ),
    );
  }
}