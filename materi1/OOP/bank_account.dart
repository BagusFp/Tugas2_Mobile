class BankAccount {
  double _balance = 0;

  // getter
  double get balance => _balance;

  // setter
  set deposit(double amount){
    if(amount > 0){
      _balance += amount;
    }
  }

  set withdraw(double amount){
    if(amount <= _balance){
      _balance -= amount;
    }
  }
}