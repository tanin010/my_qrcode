import 'package:flutter/material.dart';
import 'package:my_qrcode/src/utils/constant.dart';

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constant.G_COLOR,
        title: Text("แสดงข้อมูลรายชื่อ"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("รหัสวิชา"),
                      SizedBox(width: 10,),
                      Container(
                        width: 140,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                            EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Row(
                    children: <Widget>[
                      Text("ปี"),
                      SizedBox(width: 10,),
                      Container(
                        width: 120,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                            EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
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
                          DataCell(Text('30')),
                          DataCell(Text('30')),
                          DataCell(Text('10')),
                          DataCell(Text('8')),
                          DataCell(Text('30')),
                          DataCell(Text('F')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('2')),
                          DataCell(Text('581463001')),
                          DataCell(Text('มุกเอง')),
                          DataCell(Text('30')),
                          DataCell(Text('30')),
                          DataCell(Text('10')),
                          DataCell(Text('8')),
                          DataCell(Text('30')),
                          DataCell(Text('F')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('3')),
                          DataCell(Text('581463001')),
                          DataCell(Text('มุกเอง')),
                          DataCell(Text('30')),
                          DataCell(Text('30')),
                          DataCell(Text('10')),
                          DataCell(Text('8')),
                          DataCell(Text('30')),
                          DataCell(Text('F')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('4')),
                          DataCell(Text('581463001')),
                          DataCell(Text('มุกเอง')),
                          DataCell(Text('30')),
                          DataCell(Text('30')),
                          DataCell(Text('10')),
                          DataCell(Text('8')),
                          DataCell(Text('30')),
                          DataCell(Text('F')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('5')),
                          DataCell(Text('581463001')),
                          DataCell(Text('มุกเอง')),
                          DataCell(Text('30')),
                          DataCell(Text('30')),
                          DataCell(Text('10')),
                          DataCell(Text('8')),
                          DataCell(Text('30')),
                          DataCell(Text('F')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('6')),
                          DataCell(Text('581463001')),
                          DataCell(Text('มุกเอง')),
                          DataCell(Text('30')),
                          DataCell(Text('30')),
                          DataCell(Text('10')),
                          DataCell(Text('8')),
                          DataCell(Text('30')),
                          DataCell(Text('F')),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
