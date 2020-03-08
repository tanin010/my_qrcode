import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myqr_liang/src/models/student.dart';
import 'package:myqr_liang/src/models/subjects.dart';
import 'package:myqr_liang/src/pages/student/new_student.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AddStudenPage extends StatefulWidget {
  final String subjId;

  AddStudenPage({@required this.subjId});

  @override
  _AddStudenPageState createState() => _AddStudenPageState();
}

class _AddStudenPageState extends State<AddStudenPage> {
    var onTapRecognizer;

  /// this [StreamController] will take input of which function should be called

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('เพิ่มนิสิตเข้ารายวิชา'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 30),
              Image.asset(
                'assets/icon/add.png',
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'กรอกรหัสนิสิต',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    length: 10,
                    obsecureText: false,
                    animationType: AnimationType.fade,
                    shape: PinCodeFieldShape.underline,
                    animationDuration: Duration(milliseconds: 300),
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 20,
                    onChanged: (value) {
                      setState(() {
                        currentText = value;
                      });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                // error showing widget
                child: Text(
                  hasError ? "*คุณกรอกรหัสนิสิตให้ครบถ้วน" : "",
                  style: TextStyle(color: Colors.red.shade300, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: FlatButton(
                    onPressed: () async {
                      // conditions for validating
                      if (currentText.length != 10) {
                        setState(() {
                          hasError = true;
                        });
                      } else {
                        final databaseRef = Firestore.instance.collection('Students');
                        DocumentSnapshot doc = await databaseRef.document(currentText).get();
                        if(!doc.exists){
                         setState(() {
                            hasError = false;
                            scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("ไม่พบข้อมูลนิสิต"),
                              duration: Duration(seconds: 2),
                            ));
                          });
                        }else{
                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => StudentDetail(subjId: widget.subjId,std: doc)));
                        }
                      }
                    },
                    child: Center(
                        child: Text(
                      "VERIFY".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: Offset(-1, 2),
                          blurRadius: 5)
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentDetail extends StatefulWidget {
  final DocumentSnapshot std;
  final String subjId;

  StudentDetail({@required this.std,@required this.subjId});

  @override
  _StudentDetailState createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  Student student;
  Subject details;
  TextEditingController stdname = TextEditingController();
  TextEditingController stdcode = TextEditingController();
  TextEditingController stdsubject = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  
  @override
  void initState(){
    super.initState();
    student = Student.fromMap(widget.std.data);
    stdname.text = student.stdfirstName + " " + student.stdlastName;
    stdcode.text = student.stdCode;
    getSubject();
  }
  
  getSubject() async{
    DocumentSnapshot doc = await Firestore.instance.collection('Subjects').document(widget.subjId).get();
    details = Subject.fromMap(doc.data);
    stdsubject.text = details.name;
  }

  createNisitInSubject() {
    Firestore.instance.collection('Subjects')
      .document(widget.subjId)
      .collection('nisits')
      .document(student.stdCode)
      .setData({
        "factName": student.factName,
        "stdCode": student.stdCode,
        "stdfirstName": student.stdfirstName,
        "stdlastName": student.stdlastName,
        "stdYear": student.stdYear,
        "stdScore": 0.0,
        "stdGrade": 'F',
        "image": student.image,
        "regisTime": timestamp,
      }).then((_) {
        Firestore.instance.collection('Students').document(student.stdCode).updateData({'subjectCode.${details.code}': true});
      });
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('กำลังบันทึกข้อมูล  ${student.stdfirstName} เข้ารายวิชา ${stdsubject.text}')));
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pop(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(student.stdCode),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15,right: 10),
            child: GestureDetector(
            child: Text('บันทึก',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
            onTap: () {
              createNisitInSubject();
            },
          ),
          )
        ],
      ),
      body: ListView(
       children: <Widget>[
         Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 100.0,
                    margin: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(student.image)
                      )
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    student.stdfirstName + " " + student.stdlastName,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.graduationCap,color: Colors.grey,size: 15,),
                      SizedBox(width: 10),
                      Text(
                        student.stdYear,
                      ),
                    ],
                  ),
                   Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: new Text(
                      'ชื่อ',
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
                      readOnly: true,
                      textAlign: TextAlign.left,
                      controller: stdname,
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
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: new Text(
                      'รหัสนิสิต',
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
                      readOnly: true,
                      controller: stdcode,
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
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                new Expanded(
                  child: new Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: new Text(
                      'เพิ่มเข้ารายวิชา',
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
                      readOnly: true,
                      controller: stdsubject,
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
          ]
        )
       ], 
      )
    );
  }
}