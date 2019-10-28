import 'package:flutter/material.dart';
import 'package:my_qrcode/src/models/subjects.dart';
import 'package:my_qrcode/src/utils/constant.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> with SingleTickerProviderStateMixin{

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
        IconButton(icon: Icon(Icons.add), onPressed: () {}, iconSize: 48.0, color: Colors.white),
        IconButton(icon: Icon(Icons.delete), onPressed: () {}, iconSize: 48.0, color: Colors.white),
        IconButton(icon: Icon(Icons.update), onPressed: () {}, iconSize: 48.0, color: Colors.white),

      ], 
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ),
        physics: BouncingScrollPhysics(),
        itemCount: subject.length,
        itemBuilder: (context, index){
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
                      Text('รหัสวิชา: '+subject[index].subjectcode.toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold
                          )),
                    ],
                  ),
                );
              }
            ),
          ),
        ),
      )
      )
    );
  }
}
