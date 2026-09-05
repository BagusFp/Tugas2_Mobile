class Animal {
  String name;

  Animal(this.name);

  void eat(){
    print("${name} are eating...");
  }

  void sound(){
    print("...");
  }
}

class Monkey extends Animal {
  Monkey(String name) : super(name);

  void climb() {
    super.eat();
    print("${name} are climbing the tree...");
  }

  @override
  void sound() {
    print("Uu... aa...");
  }
}

void main(){
  Monkey monyet = Monkey("Fizi");

  print(monyet.name);
  monyet.eat();
  monyet.climb();
}