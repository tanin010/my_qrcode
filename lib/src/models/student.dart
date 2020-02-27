import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String factName;
  String image;
  String stdCode;
  String stdName;
  String stdYear;
  String subFaceName;
  dynamic subjectCode;
  Timestamp timestamp;



  Student({
    this.factName,
    this.image,
    this.stdCode,
    this.stdName,
    this.stdYear,
    this.subFaceName,
    this.subjectCode,
    this.timestamp
  });

  Student.fromMap(Map snapshot) :
    factName = snapshot['factName'] ?? '',
    image = snapshot['image'] ?? '',
    stdCode = snapshot['stdCode'] ?? '',
    stdName = snapshot['stdName'] ?? '',
    stdYear = snapshot['stdYear'] ?? '',
    subFaceName = snapshot['subFaceName'] ?? '',
    subjectCode = snapshot['subjectCode'] ?? '',
    timestamp = snapshot['timestamp'] ?? '';

  toJson() {
    return {
      "factName": factName,
      "image": image,
      "stdCode": stdCode,
      "stdName": stdName,
      "stdYear": stdYear,
      "subjectCode": subjectCode,
      "timestamp": timestamp
    };
  }

}
