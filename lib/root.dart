import 'package:flutter/material.dart';
import 'package:myqr_liang/src/pages/show_scan_qr_code/scan_qr_code.dart';


import './src/pages/edit_page/edit.dart';
import './src/pages/home_page/home.dart';
import './src/pages/student/new_student.dart';

import './src/pages/subject/subjects.dart';
import './src/utils/constant.dart';

class Root extends StatelessWidget {
  final _route = <String, WidgetBuilder>{
    Constant.HOME_ROUTE: (context) => HomePage(),
    Constant.EDIT_ROUTE: (context) => Editpage(),
    Constant.REGISTER_ROUTE: (context) => NewStudent(),
    Constant.SCANQRCODE_ROUTE: (context) => QRViewExample(),
    Constant.TABLE_ROUTE: (context) => SubjectsPage(),
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
