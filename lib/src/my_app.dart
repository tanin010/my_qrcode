import 'package:flutter/material.dart';
import 'package:my_qrcode/src/pages/edit_page/edit.dart';
import 'package:my_qrcode/src/pages/home_page/home.dart';
import 'package:my_qrcode/src/pages/register_page/register.dart';
import 'package:my_qrcode/src/pages/show_scan_qr_code_page/scan_qr_code.dart';
import 'package:my_qrcode/src/pages/table_page/teble.dart';
import 'package:my_qrcode/src/utils/constant.dart';

class MyApp extends StatelessWidget {
  final _route = <String, WidgetBuilder>{
    Constant.HOME_ROUTE: (context) => HomePage(),
    Constant.EDIT_ROUTE: (context) => Editpage(),
    Constant.REGISTER_ROUTE: (context) => RegisterPage(),
    Constant.SCANQRCODE_ROUTE: (context) => ScanQRCodePage(),
    Constant.TABLE_ROUTE: (context) => TablePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "student",
      routes: _route,
      home: HomePage(),
    );
  }
}