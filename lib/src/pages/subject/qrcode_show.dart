import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  final String code;
  final String image;

  QrCodePage({@required this.code,@required this.image});
  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  @override
  Widget build(BuildContext context) {
    final message = '${widget.code}';
    final qrFutureBuilder = FutureBuilder(
        future: _loadOverlayImage(),
        builder: (ctx, snapshot) {
          final size = 280.0;
          if (!snapshot.hasData) {
            return Container(width: size, height: size);
          }
          return CustomPaint(
            size: Size.square(size),
            painter: QrPainter(
              data: message,
              version: QrVersions.auto,
              color: Color(0xff1a5441),
              emptyColor: Color(0xffeafcf6),
              // size: 320.0,
              embeddedImage: snapshot.data,
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size.square(60),
              ),
            ),
          );
        },
      );
      return Material(
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
                      child: qrFutureBuilder,
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
      );
    }
  }
  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/images/4.0x/logo_yakka.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
