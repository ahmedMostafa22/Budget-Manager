import 'package:budget_manager/constants.dart';
import 'package:budget_manager/screens/add_category.dart';
import 'package:budget_manager/screens/expenses_income_categories.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Constants.appBlue),
              backgroundColor: Constants.appWhite,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                      child: Text(
                    'Expenses',
                    style: TextStyle(color: Constants.appBlue),
                  )),
                  Tab(
                      child: Text('Income',
                          style: TextStyle(color: Constants.appBlue))),
                ],
              ),
              title: Text(
                'Categories',
                style: TextStyle(
                  color: Constants.appBlue,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCategory()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.add),
                  ),
                )
              ],
            ),
            body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ExpenseIncomeCategories(type: 'Expenses',),
                  ExpenseIncomeCategories(type: 'Income',),
                ])));
  }
}
