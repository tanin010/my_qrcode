class Student {
  String factName;
  String stdCode;
  String stdName;
  String stdYear;
  String subFaceName;
  String subjectCode;



  Student({
    this.factName,
    this.stdCode,
    this.stdName,
    this.stdYear,
    this.subFaceName,
    this.subjectCode
  });

  Student.fromMap(Map snapshot) :
    factName = snapshot['factName'] ?? '',
    stdCode = snapshot['stdCOde'] ?? '',
    stdName = snapshot['stdName'] ?? '',
    stdYear = snapshot['stdYear'] ?? '',
    subFaceName = snapshot['subFaceName'] ?? '',
    subjectCode = snapshot['subjectCode'] ?? '';

}
