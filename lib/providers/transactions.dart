import 'package:budget_manager/models/transaction.dart';
import 'package:flutter/cupertino.dart';

class TransactionsProvider with ChangeNotifier {
  List<Transaction> categories = [];
  fetchTransactions() {}
  getAccountOrCategoryTransactions(String id,String type) {}
  makeTransaction(Transaction transaction) {}
}
