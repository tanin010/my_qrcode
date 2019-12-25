import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myqr_liang/src/pages/show_scan_qr_code/scan_qr_code.dart';
import 'package:myqr_liang/src/service/create_image_qr_code.dart';
import 'package:myqr_liang/src/utils/constant.dart';





class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('หน้าหลัก'),
      ),
      body: ListView(
        children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 160,
                      height: 160,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return QRViewExample();//ไปหน้าscan_qr_code
                          }));
                        },
                        child: Card(
                          color: Constant.V_COLOR,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(
                                  "https://cdn1.iconfinder.com/data/icons/qr-code-2/65/4-512.png",
                                  height: 100,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "QRCode",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 19),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 160,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Constant.REGISTER_ROUTE);
                        },
                        child: Card(
                          color: Constant.B_COLOR,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Image.network(
                                  "https://cdn0.iconfinder.com/data/icons/simple-seo-and-internet-icons/512/person_add-512.png",
                                  height: 100,
                                  color: Colors.white,
                                ),
                                Text(
                                  "เพิ่มข้อมูล",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
                                      color: Colors.white, fontSize: 20),
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
                        onPressed: () {
                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) =>  CreateimageqrcodePage())
                          );
                        },
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
                                  "แสดงนิสิต",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
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
            ),
        ],
      ),
    );
  }
}
