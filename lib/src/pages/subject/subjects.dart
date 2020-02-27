import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myqr_liang/src/models/subjects.dart';
import 'package:myqr_liang/src/pages/subject/students_subject.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> with SingleTickerProviderStateMixin{

  List<Subject> subject;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("แสดงรายวิชา"),
        ),
        body: StreamBuilder(
                    stream: Firestore.instance.collection('Subjects').snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasData){
                        subject = snapshot.data.documents
                          .map((doc) => Subject.fromMap(doc.data)).toList();
                        
                        return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: subject.length,
                        itemBuilder: (buildContext, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, 
                                      MaterialPageRoute(builder: (context) => ListStudensPage(uid: subject[index].uid)));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      height: MediaQuery.of(context).size.width / 2 - 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: FadeInImage(
                                          image: NetworkImage(subject[index].image),
                                          fit: BoxFit.cover,
                                          placeholder:
                                              AssetImage('assets/icon/picture.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(subject[index].name,
                                    style: Theme.of(context).textTheme.body2),
                                SizedBox(width: 5),
                                Text(
                                    'รหัสวิชา: ' +
                                        subject[index].code.toString(),
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        });
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
