class User {
  // String id;
  // final String name;
  // final int age;
  String ? id;
  String ?title;
  String ?note;
  int ?isCompleted;
  String ?date;
  String ?startTime;
  String ?endTime;
  int ?color;
  int ?remind;
  String ?repeat;
  String ?enrollment_code;
  //final DateTime birthday;
  User({
    this.id = ' ',
    // required this.name,
    // required this.age,
    //required this.birthday,
    required this.enrollment_code,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.remind,
    required this.repeat,
    
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'enrollment_code':enrollment_code,
        'title': title,
        'note': note,
        'isCompleted': isCompleted,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'color': color,
        'remind': remind,
        'repeat': repeat,
        
        // 'birthday' : birthday,
      };
  // static User fromJson(Map<String, dynamic> json) => User(
  //           id: json['id'],
  //           enrollment_code: json['enrollment_code'],
  //       // birthday: (json['birthday'] as Timestamp ).toDate(),
  //       //birthday: json['birthday']
  //           title:json['title'],
  //           note :json['note'],
  //           isCompleted : json['isCompleted'],
  //           date : json['date'],
  //           startTime : json['startTime'],
  //           endTime : json['endTime'],
  //           color : json['color'],
  //           remind : json['remind'],
  //           repeat : json['repeat'],
  //     );

  User.fromJson(Map<String, dynamic>json){
    id=json['id'];
    title=json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
    enrollment_code =json['enrollment_code'];
  }

}

