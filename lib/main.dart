import 'package:budget_manager/providers/accounts.dart';
import 'package:budget_manager/providers/categories.dart';
import 'package:budget_manager/providers/transactions.dart';
import 'package:budget_manager/screens/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => CategoriesProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TransactionsProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AccountsProvider(),
      )
    ], child: MaterialApp(debugShowCheckedModeBanner: false, home: Intro()));
  }
}
