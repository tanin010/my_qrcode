import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myqr_liang/src/models/subjects.dart';
import 'package:myqr_liang/src/service/nisitmanage.dart';


final databaseRef = Firestore.instance.collection('/Students');
User user;
final DateTime timestamp = DateTime.now();
class NewStudent extends StatefulWidget {
  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {

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
  
  void createNisit(String stdcode,String code) async{
    DocumentSnapshot doc = await databaseRef.document(stdcode).get();

    if(!doc.exists){
      databaseRef.document(stdCode).setData({
        "stdCode": stdCode,
        "subjectCode": subjectCode,
        "stdName": stdName,
        "factName": factName,
        "subFaceName": subFactName,
        "stdYear": stdYear,
        "timestamp": timestamp
      }).then((user){
        Firestore.instance.collection('Subjects').document(code).collection('nisits').add({
          "stdCode": stdCode,
          "stdName": stdName,
          "factName": factName,
          "stdYear": stdYear,
          "timestamp": timestamp
        });
      }).catchError((error) {
        print(error);
      });

      doc = await databaseRef.document(stdCode).get();
       _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('กำลังบันทึกข้อมูล คุณ $stdName')));
       Navigator.pop(context);
    }else{
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('มีชื่อ $stdName อยู่แล้ว')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child:Text('เพิ่มข้อมูลนิสิต',style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('บันทึกข้อมูลนิสิตลงในรายวิชา',style:TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey
                )),
              ),
              SizedBox(height: 10.0),
              Center(
                  child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0),
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
                          controller: _controllers2,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'วิชาเรียน',
                            icon: Icon(Icons.accessibility_new),
                          ),
                          onSaved: (val) {
                            subjectCode = val;
                          },
                          
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('Subjects').snapshots(),
                          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                            if(snapshot.hasData){
                              subject = snapshot.data.documents
                                .map((doc) => Subject.fromMap(doc.data)).toList();
                              return PopupMenuButton<String>(
                                icon: Icon(Icons.arrow_drop_down),
                                onSelected: (String value){
                                  _controllers2.text = value;
                                  
                                },
                                itemBuilder: (buildcontext) {
                                  return subject.map<PopupMenuItem<String>>((Subject value) {
                                    return new PopupMenuItem(child: new Text(value.name), value: value.uid.toString());
                                  }).toList();
                                  
                                },
                              );
                            }else{
                              return Center(
                                child: Text('กำลังโหลดข้อมูล'),
                              );
                            }
                        }),
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
                              if(_formKey.currentState.validate()){
                                _formKey.currentState.save();
                                createNisit(stdCode,subjectCode);
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
