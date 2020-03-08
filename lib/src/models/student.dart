import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String factName;
  String image;
  String stdCode;
  String stdfirstName;
  String stdlastName;
  String stdYear;
  String subFaceName;
  dynamic subjectCode;
  Timestamp timestamp;



  Student({
    this.factName,
    this.image,
    this.stdCode,
    this.stdfirstName,
    this.stdlastName,
    this.stdYear,
    this.subFaceName,
    this.subjectCode,
    this.timestamp
  });

  Student.fromMap(Map snapshot) :
    factName = snapshot['factName'] ?? '',
    image = snapshot['image'] ?? '',
    stdCode = snapshot['stdCode'] ?? '',
    stdfirstName = snapshot['stdfirstName'] ?? '',
    stdlastName = snapshot['stdlastName'] ?? '',
    stdYear = snapshot['stdYear'] ?? '',
    subFaceName = snapshot['subFaceName'] ?? '',
    subjectCode = snapshot['subjectCode'] ?? '',
    timestamp = snapshot['timestamp'] ?? '';

  toJson() {
    return {
      "factName": factName,
      "image": image,
      "stdCode": stdCode,
      "stdfirstName": stdfirstName,
      "stdlastName": stdlastName,
      "stdYear": stdYear,
      "subjectCode": subjectCode,
      "timestamp": timestamp
    };
  }

}
