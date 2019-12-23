class Subject {
  final String name;
  final int code;
  final String uid;

  Subject({
    this.name, 
    this.code,
    this.uid
  });

  Subject.fromMap(Map snapshot):
    uid = snapshot['uid'] ?? '',
    code = snapshot['code'] ?? '',
    name = snapshot['name'] ?? '';

  toJson(){
    return {
      'uid': uid,
      'code': code,
      'name': name
    };
  }
  
}


