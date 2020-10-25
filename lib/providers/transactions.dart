import 'package:budget_manager/models/transaction.dart';
import 'package:flutter/cupertino.dart';

class TransactionsProvider with ChangeNotifier {
  List<Transactions> categories = [];
  fetchTransactions() {}
  getAccountOrCategoryTransactions(String id,String type) {}
  makeTransaction(Transactions transaction) {} //done
}
