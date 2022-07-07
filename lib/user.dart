// class User{
//   String id;
//   final String name;
//   final int age;
//   //final DateTime birthday;
//   User({
//     this.id = ' ',
//     required this.name,
//     required this.age,
//     //required this.birthday,
//   });
//
//   get title => title;
//   get color => color;
//   get startTime => startTime;
//
//   get endTime => endTime;
//
//   Map<String,dynamic> toJson() => {
//     'id':  id,
//     'name' : name,
//     'age' : age,
//     // 'birthday' : birthday,
//   };
//   static User fromJson(Map<String,dynamic> json)=>User(
//     id : json['id'],
//     name: json['name'],
//     age: json['age'],
//     // birthday: (json['birthday'] as Timestamp ).toDate(),
//     //birthday: json['birthday']
//   );
// }