import 'package:budget_manager/screens/accounts.dart';
import 'package:budget_manager/screens/categories.dart';
import 'package:budget_manager/screens/transactions.dart';
import 'package:budget_manager/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Constants.appBlue,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DrawerItem(
              text: 'Accounts',
              icon: Icons.credit_card,
              function: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Accounts()));
              },
            ),
            DrawerItem(
              text: 'Categories',
              icon: Icons.category,
              function: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Categories()));
              },
            ),
            DrawerItem(
              text: 'Transactions',
              icon: Icons.view_list,
              function: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Transactions()));
              },
            ),
            DrawerItem(
              text: 'Default currency',
              icon: Icons.attach_money,
              function: () {},
            ),
            DrawerItem(
              text: 'Rate us',
              icon: Icons.star,
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
