import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myqr_liang/src/models/liststudent.dart';
import 'package:myqr_liang/src/models/student.dart';
import 'package:myqr_liang/src/models/subjects.dart';
import 'package:myqr_liang/src/pages/home_page/home.dart';

final userRef = Firestore.instance.collection('Students');
class ControllerNisit extends StatefulWidget {
  final List idnisit;

  ControllerNisit({@required this.idnisit});

  @override
  _ControllerNisitState createState() => _ControllerNisitState();
}

class _ControllerNisitState extends State<ControllerNisit> {
  TextEditingController stdName = TextEditingController();
  TextEditingController subName = TextEditingController();
  TextEditingController stdCode = TextEditingController();
  TextEditingController stdScore = TextEditingController();
  ListStudent nisit;
  FutureBuilder builder;
  Subject details;

  getSubject() async{
    DocumentSnapshot doc = await Firestore.instance.collection('Subjects').document(widget.idnisit[1]).get();
    details = Subject.fromMap(doc.data);
    subName.text = details.name;
  }
  updateNisit() {
    Firestore.instance.collection('Subjects').document(details.uid).collection('nisits').document(nisit.stdCode).updateData({'stdScore': double.parse(stdScore.text)});
  }

  @override
  void initState(){
    super.initState();
    builder = FutureBuilder(
      future: getUsertById(widget.idnisit[1],widget.idnisit[0]),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator()
          );
        }
        nisit = snapshot.data;
        stdName.text = nisit.stdName;
        stdCode.text = nisit.stdCode;
        stdScore.text = nisit.stdScore.toString();
        getSubject();
        return Column(
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
                        image: CachedNetworkImageProvider(nisit.image)
                      )
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    nisit.stdName,
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.graduationCap,color: Colors.grey,size: 15,),
                      SizedBox(width: 10),
                      Text(
                        nisit.stdYear,
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
                      controller: stdName,
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
                      controller: stdCode,
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
                      'วิชา',
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
                      controller: subName,
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
                      'คะแนน',
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
                      controller: stdScore,
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
            RaisedButton(
              onPressed: updateNisit,
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0.0),
                side: BorderSide(color: Colors.blueAccent)
              ),
              child: Text('เพิ่มรายวิชา',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold)),
            )
          ]
        );
      },
    );
  }


  Future<ListStudent> getUsertById(String subcode,String stdcode) async {
    var doc = await getDocumentById(subcode,stdcode);
    return  ListStudent.fromMap(doc.data) ;
  }

  Future<DocumentSnapshot> getDocumentById(String subcode,String stdcode){
    return Firestore.instance.collection('Subjects').document(subcode).collection('nisits').document(stdcode).get();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Icon(Icons.close),
              ),
            ),
          ),
          builder
        ],
      ),
    );
  }
}