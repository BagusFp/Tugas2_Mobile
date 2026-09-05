class Student {
  String? name;
  late String studentId;
  int? age;

  // Student(this.name, this.studentId, this.age);
  Student({
    required this.name,
    required this.studentId,
    this.age
  });

  void takeTest(){
    print("${this.name} taking test...");
  }
}

// void hitungLuas({ required int panjang, required int lebar }){

// }

void main(){
  // instansiasi
  var student = Student(
    name: "Aliyan Alfin Izzudien",
    studentId: "124230021",
    age: 22,
  );
  
  print(student.studentId);
  student.takeTest();
}