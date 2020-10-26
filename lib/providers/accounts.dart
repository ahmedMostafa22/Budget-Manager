import 'package:budget_manager/database/database_helper.dart';
import 'package:budget_manager/models/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class AccountsProvider with ChangeNotifier {
  List<Account> accounts = [];
  final String _accountTable = "accountTable";
  final String accColId = "id";
  final String accColName = "AccountName";
  final String accColbalance = "AccountBalance";
  final String accColIconIndex = "IconIndex";
  final String accColColorIndex = "ColorIndex";
  

  fetchAccounts() async {
    if (accounts.isEmpty) {
      DatabaseHelper databaseHelper = DatabaseHelper();
      Database _database = await databaseHelper.database;
      final List<Map<String, dynamic>> accountsRes =
          await _database.query(_accountTable);
      accounts = List.generate(
          accountsRes.length,
          (index) => Account(
              balance: accountsRes[index]["AccountBalance"],
              colorIndex: accountsRes[index]["ColorIndex"],
              name: accountsRes[index]["AccountName"],
              id: accountsRes[index]["id"],
              iconIndex: accountsRes[index]["IconIndex"]));
      notifyListeners();
    }
  }

  Future<void> addAccount(Account account) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    int res = await _database.insert(_accountTable, account.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    accounts.add(Account(
        id: res,
        name: account.name,
        balance: account.balance,
        iconIndex: account.iconIndex,
        colorIndex: account.colorIndex));
    notifyListeners();
  }

  editAccount(Account account) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    Map<String, dynamic> row = {
      accColColorIndex: account.colorIndex,
      accColIconIndex: account.iconIndex,
      accColName: account.name,
      accColbalance: account.balance,
    };
    await _database.update(_accountTable, row,
        where: "$accColId = ?", whereArgs: [account.id]);
    for (int i = 0; i < accounts.length; i++)
      if (accounts.elementAt(i).id == account.id) {
        accounts[i] = account;
        print(accounts[i].balance);
        break;
      }
    notifyListeners();
  }

  Future<Account> getAccountById(int id) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    var sql = "SELECT * FROM $_accountTable WHERE $accColId = $id ";
    var result = await _database.rawQuery(sql);
    return Account.fromMap(result.first);
  }

  deleteAccount(int accId) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    accounts.removeWhere((element) => element.id == accId);
    notifyListeners();
    return _database
        .delete(_accountTable, where: "$accColId = ?", whereArgs: [accId]);
  }

  changeAmount(double amount, int id) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    Map<String, dynamic> row = {accColbalance: amount};
    await _database
        .update(_accountTable, row, where: "$accColId = ?", whereArgs: [id]);
    for (int i = 0; i < accounts.length; i++)
      if (accounts.elementAt(i).id == id) {
        accounts[i].balance = amount;
        break;
      }
    notifyListeners();
  }
}
