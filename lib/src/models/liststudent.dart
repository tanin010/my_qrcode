import 'package:cloud_firestore/cloud_firestore.dart';

class ListStudent {
  String factName;
  String stdCode;
  String stdName;
  String stdYear;
  String subjectCode;
  String image;
  Timestamp regisTime;



  ListStudent({
    this.factName,
    this.stdCode,
    this.stdName,
    this.stdYear,
    this.subjectCode,
    this.image,
    this.regisTime
  });

  ListStudent.fromMap(Map snapshot) :
    factName = snapshot['factName'] ?? '',
    stdCode = snapshot['stdCode'] ?? '',
    stdName = snapshot['stdName'] ?? '',
    stdYear = snapshot['stdYear'] ?? '',
    image = snapshot['image'] ?? '',
    subjectCode = snapshot['subjectCode'] ?? '',
    regisTime = snapshot['timestamp'] ?? '';

}