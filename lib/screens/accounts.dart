import 'package:budget_manager/models/account.dart';
import 'package:budget_manager/widgets/account_list_item.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'add_account.dart';

class Accounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Constants.appBlue),
        backgroundColor: Constants.appWhite,
        title: Text(
          'Accounts',
          style: TextStyle(
            color: Constants.appBlue,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddAccount()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          AccountItem(
            account: Account(
                name: 'Wallet', balance: 4000, iconIndex: 3, colorIndex: 2),
          ),
          AccountItem(
            account: Account(
                name: 'Visa', balance: 3000, iconIndex: 5, colorIndex: 3),
          )
        ],
      ),
    );
  }
}
