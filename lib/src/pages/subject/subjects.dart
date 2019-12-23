import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:myqr_liang/src/models/subjects.dart';
import 'package:myqr_liang/src/utils/constant.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> with SingleTickerProviderStateMixin{

  List<Subject> subject;
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width / 2;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Constant.G_COLOR,
          title: Text("แสดงข้อมูลรายชื่อ"),
        ),
        body: FabCircularMenu(
            ringColor: Colors.grey,
            options: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  iconSize: 48.0,
                  color: Colors.white),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                  iconSize: 48.0,
                  color: Colors.white),
              IconButton(
                  icon: Icon(Icons.update),
                  onPressed: () {},
                  iconSize: 48.0,
                  color: Colors.white),
            ],
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('Subjects').snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasData){
                        subject = snapshot.data.documents
                          .map((doc) => Subject.fromMap(doc.data)).toList();
                        
                        return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        physics: BouncingScrollPhysics(),
                        itemCount: subject.length,
                        itemBuilder: (buildContext, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Container(
                                    width: _width,
                                    height: _width - 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      /*child: FadeInImage(
                                  image: NetworkImage(_categoryImage[index]),
                                  fit: BoxFit.cover,
                                  placeholder:
                                      AssetImage('assets/images/loading.gif'),
                                ),*/
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
                ),
              ),
            )));
  }
}
