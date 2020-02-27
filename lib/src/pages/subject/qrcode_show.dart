
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  final String code;
  final String subCode;

  QrCodePage({@required this.code,@required this.subCode});
  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    final message = "${widget.code},${widget.subCode}";
      return Scaffold(
        appBar: AppBar(
          title: Text('QR Code นิสิต'),
        ),
        body: Material(
          color: Colors.white,
          child: SafeArea(
            top: true,
            bottom: true,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 280,
                        child: QrImage(
                          data: message,
                          version: QrVersions.auto,
                          size: 320,
                          gapless: false,
                          
                          errorStateBuilder: (cxt, err) {
                            return Container(
                              child: Center(
                                child: Text(
                                  "เกิดข้อผิดพลาดบางอย่าง ไม่สามารถโหลด QR CODE ได้...",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                        .copyWith(bottom: 40),
                    child: Text(message),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
