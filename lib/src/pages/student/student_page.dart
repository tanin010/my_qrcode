import 'package:flutter/material.dart';
import 'package:my_qrcode/src/utils/constant.dart';

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constant.V_COLOR,
        title: Text("ข้อมูลนิสิต"),
      ),
      body: ListView(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FittedBox(
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('ลำดับ'),
                  ),
                  DataColumn(
                    label: Text('รหัสนิสิต'),
                  ),
                  DataColumn(
                    label: Text('ชื่อ-นามสกุล'),
                  ),
                  DataColumn(
                    label: Text('mid'),
                  ),
                  DataColumn(
                    label: Text('final'),
                  ),
                  DataColumn(
                    label: Text('คะแนนเก็บ ครั้ง1'),
                  ),
                  DataColumn(
                    label: Text('คะแนนเก็บ ครั้ง2'),
                  ),
                  DataColumn(
                    label: Text('คะแนนรวม'),
                  ),
                  DataColumn(
                    label: Text('เกรด'),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('581463001')),
                    DataCell(Text('มุกเอง')),
                    DataCell(Text('40')),
                    DataCell(Text('40')),
                    DataCell(Text('10')),
                    DataCell(Text('8')),
                    DataCell(
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    DataCell(Text('F')),
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150, left: 150),
            child: Container(
              height: 40,
              width: double.infinity,
              color: Constant.V_COLOR,
              child: FlatButton(
                child: Text(
                  "บันทึก",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.blue,
        onPressed: () {
          print('hello');
        },
      ),
    );
  }
}
