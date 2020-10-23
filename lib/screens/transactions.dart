import 'package:budget_manager/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Transactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Constants.appBlue),
        backgroundColor: Constants.appWhite,
        title: Text(
          'Transactions',
          style: TextStyle(
            color: Constants.appBlue,
          ),
        ),
      ),
      body: ListView(
        children: [
          TransactionItem(
            categoryIcon: Icons.restaurant,
            transactedToName: 'Food',
            iconBackgroundColor: Colors.indigo,
            transactionAmount: 75.0,
            accountIcon: Icons.credit_card,
            accountName: 'Visa',
          ),
          TransactionItem(
            categoryIcon: Icons.local_mall,
            transactedToName: 'Cloths',
            iconBackgroundColor: Colors.blue,
            transactionAmount: 500.0,
            accountIcon: Icons.account_balance_wallet,
            accountName: 'Wallet',
          ),
          TransactionItem(
            categoryIcon: Icons.lightbulb_outline,
            transactedToName: 'Electricity',
            iconBackgroundColor: Colors.yellow,
            transactionAmount: 175.0,
            accountIcon: Icons.credit_card,
            accountName: 'Visa',
          ),
          TransactionItem(
            categoryIcon: Icons.card_giftcard,
            transactedToName: 'Gifts',
            iconBackgroundColor: Colors.red,
            transactionAmount: 300.0,
            accountIcon: Icons.credit_card,
            accountName: 'Visa',
          ),
          TransactionItem(
            categoryIcon: Icons.smoking_rooms,
            transactedToName: 'Cigars',
            iconBackgroundColor: Colors.black,
            transactionAmount: 150.0,
            accountIcon: Icons.credit_card,
            accountName: 'Visa',
          ),
        ],
      ),
    );
  }
}
