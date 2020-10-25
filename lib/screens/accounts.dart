import 'package:budget_manager/models/account.dart';
import 'package:budget_manager/models/category.dart';
import 'package:budget_manager/utils/AccountDatabase.dart';

import 'package:budget_manager/widgets/account_list_item.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'add_account.dart';

class Accounts extends StatelessWidget {
  @override
  // List<Account> accounts = [];
  // List<Category> categories = [];
  // final DatabaseHelper _databaseHelper = DatabaseHelper();
  // Account currentAccount;
  // Category currentCategory;
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
          // print("Wallet");
          // currentCategory = Category(
          //     amount: 555,
          //     colorIndex: 1,
          //     iconIndex: 1,
          //     name: "Apple",
          //     type: "Fruit");

          // currentAccount = Account(
          //     name: "Visa", balance: 500, colorIndex: 2, iconIndex: 4);

          //     categories = await _databaseHelper.getAllCategories();
          //     print(categories[0].amount);
          //   },
          AccountItem(
            account: Account(
                name: 'Wallet', balance: 4000, iconIndex: 3, colorIndex: 2),
          ),

          // List<Account> myAccount = await _databaseHelper.getAllAccounts();

          // accounts = myAccount;

          // print(myAccount.length);

          AccountItem(
            account: Account(
                name: 'Visa', balance: 3000, iconIndex: 5, colorIndex: 3),
          ),
        ],
      ),
    );
  }
}
