import 'package:cloud_firestore/cloud_firestore.dart';

class ListStudent {
  String factName;
  String stdCode;
  String stdName;
  String stdGrade;
  String stdYear;
  double stdScore;
  String image;
  Timestamp regisTime;



  ListStudent({
    this.factName,
    this.stdCode,
    this.stdName,
    this.stdYear,
    this.stdGrade,
    this.stdScore,
    this.image,
    this.regisTime
  });

  ListStudent.fromMap(Map snapshot) :
    factName = snapshot['factName'] ?? '',
    stdCode = snapshot['stdCode'] ?? '',
    stdName = snapshot['stdName'] ?? '',
    stdYear = snapshot['stdYear'] ?? '',
    stdGrade = snapshot['stdGrade'] ?? '',
    stdScore = snapshot['stdScore'] ?? '',
    image = snapshot['image'] ?? '',
    regisTime = snapshot['regisTime'] ?? '';

}