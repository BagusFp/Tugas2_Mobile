import 'bank_account.dart';

void main(){
  BankAccount myBankAccount = BankAccount();

  myBankAccount.deposit = 100000;

  print(myBankAccount.balance);

  myBankAccount.withdraw = 1000000;

  print(myBankAccount.balance);

}