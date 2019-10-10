import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:my_qrcode/src/utils/constant.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/rendering.dart';

import 'dart:typed_data';

import 'dart:async';

import 'package:path_provider/path_provider.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  GlobalKey globalKey = GlobalKey();

  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();
  final TextEditingController _textController5 = TextEditingController();
  final TextEditingController _textController6 = TextEditingController();

  String _dataQRCode = "";

  @override
  void initState() {
    super.initState();

    _textController1.addListener(Change);
    _textController2.addListener(Change);
    _textController3.addListener(Change);
    _textController4.addListener(Change);
    _textController5.addListener(Change);
    _textController6.addListener(Change);
  }

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
                  controller: _textController1,
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
                  controller: _textController2,
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
                  controller: _textController3,
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
                  controller: _textController4,
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
                  controller: _textController5,
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
                  controller: _textController6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                  ),
                  keyboardType: TextInputType.text,
                ),
                _buildContent(),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(right: 120,left: 120),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    color: Constant.B_COLOR,
                    child: FlatButton(
                      child: Text("บันทึก",style: TextStyle(color: Colors.white),),
                      onPressed: shared,
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
  Future shared() async {
    try {
      RenderRepaintBoundary boundary =
      globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = MethodChannel('cm.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  _buildContent() => Padding(
    padding: EdgeInsets.only(left: 30, right: 30, top: 40),
    child: Center(
      child: Column(
        children: <Widget>[
          RepaintBoundary(
            key: globalKey,
            child: QrImage(
              backgroundColor: Colors.white,
              data: _dataQRCode,
              size: 150,
              onError: (exception) {
                print("Error QRCODE: $exception");
              },
            ),
          )
        ],
      ),
    ),
  );

  Change() {
    setState(() {
      _dataQRCode = _textController1.text;
      _dataQRCode = _textController2.text;
      _dataQRCode = _textController3.text;
      _dataQRCode = _textController4.text;
      _dataQRCode = _textController5.text;
      _dataQRCode = _textController6.text;
    });
  }
}
