import 'dart:io';  
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:myqr_liang/src/models/subjects.dart';
import 'package:myqr_liang/src/service/nisitmanage.dart';  
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore    
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:uuid/uuid.dart';


final databaseRef = Firestore.instance.collection('/Students');
User user;
final DateTime timestamp = DateTime.now();
class NewStudent extends StatefulWidget {
  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {

  File _image;
  File file;
  String postId = Uuid().v4(); 
  String stdCode;
  String subjectCode;
  String stdName;
  String factName;
  String subFactName;
  String stdYear;

  final TextEditingController _controllers = new TextEditingController();
  final TextEditingController _controllers2 = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var items =[  'คณะเกษตร',
  'คณะบริหารธุรกิจ',	       
  'คณะสังคมศาสตร์',
  'คณะประมง',	       
  'คณะสัตวแพทยศาสตร์',
  'คณะมนุษยศาสตร์',	       
  'คณะวนศาสตร์',	       
  'คณะวิทยาศาสตร์',
  'คณะวิศวกรรมศาสตร์',	      
  'คณะศึกษาศาสตร์',	    
  'คณะเศรษฐศาสตร์'];

  List<Subject> subject;
  

  @override
  void dispose(){
    _controllers.dispose();
    _controllers2.dispose();
    super.dispose();
  }
  
  void createNisit() async{
    DocumentSnapshot doc = await databaseRef.document(stdCode).get();

    if(!doc.exists){
      await compressImage();
      String url = await uploadFile(file);
      databaseRef.document(stdCode).setData({
        "stdCode": stdCode,
        "subjectCode": {},
        "stdName": stdName,
        "factName": factName,
        "subFaceName": subFactName,
        "stdYear": stdYear,
        "image": url,
        "timestamp": timestamp
      });
      doc = await databaseRef.document(stdCode).get();
       _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('กำลังบันทึกข้อมูล คุณ $stdName')));
       Navigator.pop(context);
    }else{
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('มีชื่อ $stdName อยู่แล้ว')));
    }
  }

  uploadFile(imageFile) async{
    StorageUploadTask uploadTask = FirebaseStorage.instance.ref().child('students_pic/${Path.basename(_image.path)}')
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(icon: Icon(Icons.close), onPressed: () {
              Navigator.pop(context);
            }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child:Text('เพิ่มข้อมูลนิสิต',style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
                ),),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('บันทึกข้อมูลนิสิตลงในรายวิชา',style:TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey
                  )),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                  child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _image != null    
                        ? Container(
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: getImage,
                            child: CircleAvatar(
                              backgroundImage: FileImage(_image),
                            ),
                          ),
                        )
                        : Container(
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: getImage,
                            child: CircleAvatar(
                              child: Image.network('https://firebasestorage.googleapis.com/v0/b/myqrliang.appspot.com/o/subjects_pic%2Fuser.png?alt=media&token=e0c4b41f-b833-4db5-bd2b-27f6dde61b19')
                              
                            ),
                          )
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val.trim().length != 10){
                              return 'รหัสนิสิตไม่ถูกต้อง';
                            }else{
                              return null;
                            }
                          },
                          
                          onSaved: (val) {
                            stdCode = val;
                          },
                          decoration: InputDecoration(
                            hintText: 'รหัสนิสิต',
                            icon: Icon(Icons.lock)
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty){
                              return 'กรุณากรอกข้อมูล';
                            }else{
                              return null;
                            }
                          },
                          onSaved: (val) {
                            stdName = val;
                          },
                          decoration: InputDecoration(
                            hintText: 'ชื่อ-นามสกุล',
                            icon: Icon(Icons.person)
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _controllers,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'คณะ',
                            icon: Icon(Icons.accessibility_new),
                          ),
                          onSaved: (val) {
                            factName = val;
                          },
                          
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.arrow_drop_down),
                          onSelected: (String value){
                            _controllers.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return items.map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty){
                              return 'กรุณากรอกข้อมูล';
                            }else{
                              return null;
                            }
                          },
                          onSaved: (val) {
                            subFactName = val;
                          },
                          decoration: InputDecoration(
                            hintText: 'สาขา',
                            icon: Icon(Icons.adb)
                          ),

                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          validator: (val) {
                            if (val.trim().length > 1 || val.isEmpty){
                              return 'ข้อมูลชั้นปีไม่ถูกต้อง';
                            }else{
                              return null;
                            }
                          },
                          onSaved: (val) {
                            stdYear = val;
                          },
                          decoration: InputDecoration(
                            hintText: 'ชั้นปี',
                            icon: Icon(Icons.star)
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 30.0),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: RaisedButton(
                            onPressed: () {
                              if(_image == null){
                                Widget okButton = FlatButton(
                                  child: Text("แก้ไข"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                                AlertDialog alert = AlertDialog(
                                  title: Text("ข้อมูลไม่ครบถ้วน"),
                                  content: Text("กรุณาเพิ่มรูปภาพประจำตัว."),
                                  actions: [
                                    okButton,
                                  ],
                                );
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              }else{
                                if(_formKey.currentState.validate()){
                                  _formKey.currentState.save();
                                  createNisit();
                                }
                              }
                            },
                            child: Text('บันทึกข้อมูล'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}
