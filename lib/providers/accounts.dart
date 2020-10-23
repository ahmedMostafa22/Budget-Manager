import 'package:budget_manager/models/account.dart';
import 'package:flutter/cupertino.dart';

class AccountsProvider with ChangeNotifier {
  List<Account> accounts = [];

  fetchAccounts() {}
  getAccountById(String id) {}
  addAccount(Account account) {}
  editAccount(Account account) {}
  deleteAccount(String accId) {}
  changeAmount(double amount) {}
  
}
