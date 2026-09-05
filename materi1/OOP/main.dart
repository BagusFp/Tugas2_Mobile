

void main(){
  // 1. Data Types
  int number = 123;
  double decimalNumber = 12.3;
  String name = "Zakinanda";
  bool isRaining = false;

  List<String> names = ["Zaki", "Nanda", "Faishal"];

  // for (var name in names) {
  //   print(name);
  // }

  Map<String, dynamic> biodata = {
    "name": "Aliyan Alfin Izzudien",
    "age": 22,
    "hobbies": ["Fishing", "Gaming"],
    "metadata": {

    }
  };

  List<Map<String, dynamic>> users = [
    {
      "username": "Zakinanda1234",
      "password": "12342354353452",
    },

    {
      "username": "Alfin1234",
      "password": "12342354353452abc",
    }
  ];

  Set<String> fruits = { "Anggur", "Apel", "Pisang", "Anggur" };

  // print(users[1]["password"]);

  // const waktu1 = DateTime.now(); // compile-time
  // final waktu2 = DateTime.now(); // runtime
}