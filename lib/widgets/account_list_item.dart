import 'package:budget_manager/models/account.dart';
import 'package:budget_manager/providers/accounts.dart';
import 'package:budget_manager/screens/add_account.dart';
import 'package:budget_manager/widgets/circular_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class AccountItem extends StatelessWidget {
  final Account account;
  const AccountItem({Key key, @required this.account}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.white10,
            context: context,
            builder: (context) => Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(30),
                          topStart: Radius.circular(30))),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Container(
                          width: width * 0.15,
                          height: width * 0.15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.colors[account.colorIndex],
                          ),
                          child: Icon(Constants.icons[account.iconIndex],
                              size: 40, color: Constants.appWhite)),
                      Text(account.name, style: TextStyle(fontSize: 22)),
                      Text('\$${account.balance.toString()}',
                          style: TextStyle(
                              color: Constants.appGreen, fontSize: 18)),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: width * 0.8,
                        height: height * 0.3,
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          children: [
                            CircularIconButton(
                              color: Colors.green,
                              icon: Icons.keyboard_arrow_down,
                              text: 'Recharge',
                              function: () {},
                            ),
                            CircularIconButton(
                              color: Colors.red,
                              icon: Icons.keyboard_arrow_up,
                              text: 'Transfer',
                              function: () {},
                            ),
                            CircularIconButton(
                              color: Colors.teal,
                              icon: Icons.list,
                              text: 'Transactions',
                              function: () {},
                            ),
                            CircularIconButton(
                              color: Colors.blue,
                              icon: Icons.loop,
                              text: 'Balance',
                              function: () async {
                                final _amountController =
                                    TextEditingController();
                                Navigator.pop(context);
                                showModalBottomSheet(
                                    backgroundColor: Colors.white10,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadiusDirectional.only(
                                                    topEnd: Radius.circular(30),
                                                    topStart:
                                                        Radius.circular(30))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 32.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Enter the new balance'),
                                              TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: _amountController,
                                              ),
                                              RaisedButton(
                                                onPressed: (_amountController
                                                            .text.isEmpty ||
                                                        double.tryParse(
                                                                _amountController
                                                                    .text) ==
                                                            null ||
                                                        double.parse(
                                                                _amountController
                                                                    .text) <
                                                            0.0)
                                                    ? null
                                                    : () async {
                                                        await Provider.of<
                                                                    AccountsProvider>(
                                                                context,
                                                                listen: false)
                                                            .changeAmount(
                                                                double.parse(
                                                                    _amountController
                                                                        .text),
                                                                account.id);
                                                        Navigator.pop(context);
                                                      },
                                                child: Text(
                                                  'Update',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Constants.appBlue,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                            CircularIconButton(
                              color: Colors.orange,
                              icon: Icons.edit,
                              text: 'Edit',
                              function: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddAccount(
                                              screenUseCase: 'Edit',
                                              account: account,
                                            )));
                              },
                            ),
                            CircularIconButton(
                              color: Colors.black,
                              icon: Icons.delete,
                              text: 'Delete',
                              function: () {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text(
                                              'Are you sure you want to delete this account ?'),
                                          actions: [
                                            RaisedButton(
                                                child: Text('Yes'),
                                                color: Colors.red,
                                                onPressed: () async {
                                                  await Provider.of<
                                                              AccountsProvider>(
                                                          context,
                                                          listen: false)
                                                      .deleteAccount(
                                                          account.id);
                                                  Navigator.pop(context);
                                                }),
                                            RaisedButton(
                                                child: Text('No'),
                                                color: Colors.green,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
      },
      child: ListTile(
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
    );
  }
}
