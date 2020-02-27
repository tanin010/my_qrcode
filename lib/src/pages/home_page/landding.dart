import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:myqr_liang/src/pages/show_scan_qr_code/found_info_nisit.dart';
import 'package:myqr_liang/src/pages/student/new_student.dart';
import 'package:myqr_liang/src/pages/subject/addsubject.dart';
import 'package:flutter/services.dart';

class LanddingPage extends StatefulWidget {
  @override
  _LanddingPageState createState() => _LanddingPageState();
}

class _LanddingPageState extends State<LanddingPage> with SingleTickerProviderStateMixin {
  String barcode = "";
  List<String> data;

  Future scan() async {
    try {
      BarcodeScanner.scan().then((val) {
        data = val.split(',');
        Navigator.push(context, 
          MaterialPageRoute(builder: (context) => ControllerNisit(idnisit: data)));
      }).catchError((err) {
        print(err);
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Navigate> link = [
      Navigate(image:'assets/image/scan.png',name: 'สแกนข้อมูล',link: 1),
      Navigate(image:'assets/image/student.png',name: 'เพิ่มข้อมูลนิสิต',link: NewStudent()),
      Navigate(image:'assets/image/books.png',name: 'เพิ่มรายวิชา' , link: AddSubjectPage())
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ระบบจัดการข้อมูลนิสิต'),
      ),
      body: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            physics: NeverScrollableScrollPhysics(),
            itemCount: link.length,
            itemBuilder: (buildContext, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if(link[index].link == 1){
                          scan();
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) => link[index].link));
                        }
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                         children: <Widget>[
                           Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width / 2 - 70,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: FadeInImage(
                                  image: AssetImage(link[index].image),
                                  fit: BoxFit.cover,
                                  placeholder:
                                      AssetImage('assets/icon/picture.png'),
                                ),
                              ),
                              
                          ),
                          Text(link[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                         ], 
                        )
                      ),
                    ),
                    
                  ],
                ),
              );
            }
          )
    );
  }
}

class Navigate{
  final String image;
  final String name;
  final dynamic link;

  Navigate({this.image,this.link,this.name});
}