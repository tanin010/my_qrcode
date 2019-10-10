import 'package:flutter/material.dart';
import 'package:my_qrcode/src/utils/constant.dart';

class Editpage extends StatefulWidget {
  @override
  _EditpageState createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.B_COLOR,
        centerTitle: true,
        title: Text("เพิ่มข้อมูลนักศึกษา"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(child: Text("ข้อมูลนิสิต",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "รหัสวิชา",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Prompt_Regular',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                Text(
                  "รหัสนักศึกษา",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Prompt_Regular',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Text(
                  "ชื่อ-นามสกุล",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Prompt_Regular',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                    counterText: '',
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                Text(
                  "ปี",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Prompt_Regular',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Text(
                  "คณะ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Prompt_Regular',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                Text(
                  "สาขา",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Prompt_Regular',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(right: 120,left: 120),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    color: Constant.B_COLOR,
                    child: FlatButton(
                      child: Text("บันทึก",style: TextStyle(color: Colors.white),),
                      onPressed: (){},
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
