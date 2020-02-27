class Subject {
  final String name;
  final int code;
  final String uid;
  final String image;

  Subject({
    this.name, 
    this.code,
    this.uid,
    this.image
  });

  Subject.fromMap(Map snapshot):
    uid = snapshot['uid'] ?? '',
    code = snapshot['code'] ?? '',
    image = snapshot['image'] ?? '',
    name = snapshot['name'] ?? '';

  toJson(){
    return {
      'uid': uid,
      'code': code,
      'image': image,
      'name': name
    };
  }
  
}


