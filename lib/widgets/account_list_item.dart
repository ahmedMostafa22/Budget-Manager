import 'package:budget_manager/models/account.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class AccountItem extends StatelessWidget {
  final Account account;
  const AccountItem({Key key, @required this.account}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
              width: 45,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.colors[account.colorIndex],
              ),
              child: Icon(Constants.icons[account.iconIndex],
                  color: Constants.appWhite)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(account.name),
              SizedBox(
                height: 4,
              ),
              Text(
                '\$${account.balance.toString()}',
                style: TextStyle(color: Constants.appGreen),
              )
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
