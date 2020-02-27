import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myqr_liang/src/pages/home_page/landding.dart';
import 'package:myqr_liang/src/pages/show_scan_qr_code/found_info_nisit.dart';
import 'package:myqr_liang/src/pages/student/new_student.dart';
import 'package:myqr_liang/src/pages/subject/subjects.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String barcode = "";
  List<String> data;
  PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState(){
    super.initState();
    _pageController = PageController(
      initialPage: 0
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void pageChanged(int index) {
    setState(() {
      this.selectedIndex = index;
    });
  }

  onTap(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
  }

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
    return Scaffold(
      body: PageView(
        children: <Widget>[
          SubjectsPage(),
          LanddingPage(),
        ],
        controller: _pageController,
        onPageChanged: pageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onTap,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
            title: Text("Activity"),
          ),
        ],
      ),
    );
  }
}
