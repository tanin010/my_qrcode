import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_qrcode/src/utils/constant.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              Text("หน้าเมนูMENU", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold )),
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
                      onPressed: (){
                        Navigator.pushNamed(context, Constant.SCANQRCODE_ROUTE);
                      },
                      child: Card(
                        color: Constant.V_COLOR,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.network(
                                "https://cdn1.iconfinder.com/data/icons/qr-code-2/65/4-512.png",
                                height: 100,color: Colors.white,
                              ),
                            ),
                            Text("QRCode",style: TextStyle(color: Colors.white,fontSize: 16),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    child: FlatButton(
                      onPressed: (){
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
                                height: 100,color: Colors.white,
                              ),
                              Text("เพิ่มข้อมูล",style: TextStyle(color: Colors.white,fontSize: 16),)
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
                      onPressed: (){
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
                                height: 100,color: Colors.white,
                              ),
                              Text("แสดงชื่อ",style: TextStyle(color: Colors.white,fontSize: 16),)
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
                      onPressed: (){

                      },
                      child: Card(
                        color: Constant.P_COLOR,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Image.network(
                                "https://cdn1.iconfinder.com/data/icons/materia-arrows-symbols-vol-8/24/018_320_door_exit_logout-512.png",
                                height: 100,color: Colors.white,
                              ),
                              Text("ออกระบบ",style: TextStyle(color: Colors.white,fontSize: 16),)
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
