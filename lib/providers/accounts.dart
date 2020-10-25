import 'package:budget_manager/models/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class AccountsProvider with ChangeNotifier {
  List<Account> accounts = [];
  final String accountTable = "accountTable";
  final String accColId = "id";
  final String accColName = "AccountName";
  final String accColbalance = "AccountBalance";
  final String accColIconIndex = "IconIndex";
  final String accColColorIndex = "ColorIndex";
  static Database _database;
  fetchAccounts() {} //done
  getAccountById(int id) {}    //done
  addAccount(Account account) {}    //done
  editAccount(Account account, int id) {}  //done
  deleteAccount(int accId) {}                   //done
  changeAmount(double amount, int id) {}            //done


}
