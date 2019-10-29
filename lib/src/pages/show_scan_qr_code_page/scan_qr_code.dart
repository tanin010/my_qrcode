import 'package:flutter/material.dart';
import 'package:my_qrcode/src/pages/register_page/register.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../models/student.dart';
import '../student/student_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(home: QRViewExample()));

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 6,
              child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated)),
        ],
      ),
    );
  }

  Future _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
    // find Record in Firebase
    // var document = await Firestore.instance
    //     .collection('COLLECTION_NAME')
    //     .document('TESTID1');

    // record exist
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StudentPage();
    }));
    // record not exist
    Navigator.pop(context);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
