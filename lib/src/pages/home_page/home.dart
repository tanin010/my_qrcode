import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_qrcode/src/utils/constant.dart';
import '../show_scan_qr_code_page/scan_qr_code.dart';
import '../student/new_student.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _actions(navigate, cardColor, imageUrl, cardText) {
    return Container(
      width: 160,
      height: 160,
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return navigate; //ไปหน้าscan_qr_code
          }));
        },
        child: Card(
          color: cardColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  imageUrl,
                  height: 100,
                  color: Colors.white,
                ),
              ),
              Text(
                cardText,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text("หน้าเมนูMENU",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _actions(
                      QRViewExample(),
                      Constant.V_COLOR,
                      "https://cdn1.iconfinder.com/data/icons/qr-code-2/65/4-512.png",
                      "QRCode"),
                  _actions(
                      NewStudent(),
                      Constant.B_COLOR,
                      "https://cdn0.iconfinder.com/data/icons/simple-seo-and-internet-icons/512/person_add-512.png",
                      "เพิ่มข้อมูล"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 160,
                    height: 160,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Constant.TABLE_ROUTE);
                      },
                      child: Card(
                        color: Constant.G_COLOR,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                "https://png.pngtree.com/svg/20150402/_table_icon_1188266.png",
                                height: 100,
                                color: Colors.white,
                              ),
                              Text(
                                "แสดงชื่อ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    child: FlatButton(
                      onPressed: () {},
                      child: Card(
                        color: Constant.P_COLOR,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                "https://cdn1.iconfinder.com/data/icons/materia-arrows-symbols-vol-8/24/018_320_door_exit_logout-512.png",
                                height: 100,
                                color: Colors.white,
                              ),
                              Text(
                                "ออกระบบ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
