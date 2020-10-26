import 'package:budget_manager/providers/accounts.dart';
import 'package:budget_manager/widgets/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'add_account.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  var _future;
  @override
  void initState() {
    super.initState();
    _future =
        Provider.of<AccountsProvider>(context, listen: false).fetchAccounts();
  }

  @override
  Widget build(BuildContext context) {
    AccountsProvider accountsProvider = Provider.of<AccountsProvider>(context);
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
                    MaterialPageRoute(builder: (context) => AddAccount(screenUseCase: 'Add',)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  accountsProvider.accounts.isEmpty)
                return Center(child: CircularProgressIndicator());
              else
                return ListView.builder(
                    itemCount: accountsProvider.accounts.length,
                    itemBuilder: (context, i) =>
                        AccountItem(account: accountsProvider.accounts[i]));
            }));
  }
}
