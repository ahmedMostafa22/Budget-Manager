import 'package:budget_manager/database/database_helper.dart';
import 'package:budget_manager/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class TransactionsProvider with ChangeNotifier {
  final String _transactionTable = "transactionTable";
  List<Transactions> categories = [];

  Future<List<Transactions>> fetchTransactions() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    final List<Map<String, dynamic>> transactions =
        await _database.query('categoryTable');
    return List.generate(transactions.length, (index) {
      return Transactions(
          amount: transactions[index]["TransactionAmount"],
          date: transactions[index]["TransactionDate"],
          transactingFromId: transactions[index]["TransactionFromID"],
          id: transactions[index]["id"],
          transactingToId: transactions[index]["TransactionToID"],
          transactingToType: transactions[index]["TransactionToType"]);
    });
  }

  getAccountOrCategoryTransactions(String id, String type) {}
  Future<void> createTranscation(Transactions transaction) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    await _database.insert(_transactionTable, transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
