import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  final String stdCode;
  final String subjectCode;
  final String stdName;
  final String factName;
  final String subFactName;
  final String stdYear;

  User({
    this.stdCode,
    this.stdName,
    this.factName,
    this.stdYear,
    this.subFactName,
    this.subjectCode
  });

  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      subFactName: doc['subFactName'],
      factName: doc['factName'],
      stdCode: doc['stdCode'],
      stdName: doc['stdName'],
      stdYear: doc['stdYear'],
      subjectCode: doc['subjectCode']
    );
  }
}