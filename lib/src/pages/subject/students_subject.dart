import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myqr_liang/src/models/liststudent.dart';
import 'package:myqr_liang/src/pages/subject/addstudent.dart';
import 'package:myqr_liang/src/pages/subject/qrcode_show.dart';

class ListStudensPage extends StatefulWidget {
  final String uid;

  ListStudensPage({@required this.uid});
  @override
  _ListStudensPageState createState() => _ListStudensPageState();
}

class _ListStudensPageState extends State<ListStudensPage> {
  List<ListStudent> students;
  
  showAlertDialog(BuildContext context,ListStudent students) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("ยกเลิก"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("ตกลง"),
      onPressed:  () {
        Firestore.instance.collection('Subjects').document(widget.uid).collection('nisits').document(students.stdCode).delete();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ลบรายชื่อนิสิต"),
      content: Text("คุณต้องการที่จะลบ ${students.stdName} ออกจากรายวิชา ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อนิสิต'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.userPlus), 
            onPressed: () {
              Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => AddStudenPage(subjId: widget.uid)));
            }
          )
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Subjects').document(widget.uid).collection('nisits').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            students = snapshot.data.documents
              .map((doc) => ListStudent.fromMap(doc.data)).toList();
            return Material(
              elevation: 1.0,
              child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (buildContext, index){
                return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(students[index].stdName),
                          subtitle: Text(
                              'คณะ: ' + ' ${students[index].factName}',style: TextStyle(
                                fontFamily: 'Sukhumvit'
                              ),),
                          trailing: RaisedButton(
                            onPressed: () {
                              showAlertDialog(context,students[index]);
                            },
                            child: Text(
                              'ยกเลิกลงทะเบียน',style: TextStyle(
                                fontFamily: 'Sukhumvit'
                              ),
                            ),
                          )
                        ),
                        Divider(
                          height: 1.0,
                        ),
                        ListTile(
                          leading: IconButton(
                            icon: Icon(FontAwesomeIcons.qrcode),
                            onPressed: () {
                              Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => QrCodePage(code: students[index].stdCode,subCode: widget.uid)));
                            },
                          ),
                          title: Text('เลขที่ Code: '+'${students[index].stdCode}',style: TextStyle(
                                fontFamily: 'Sukhumvit',
                            ),
                          ),
                          subtitle: Text('ลงทะเบียนเมื่อ: ' + '${DateTime.parse(students[index].regisTime.toDate().toString())}'),
                        )
                      ],
                    ),
                  );
              },
            ),
          );
          }else{
            return Center(
              child: Text('กำลังดึงข้อมูล'),
            );
          }
        },
      )
    );
  }
}