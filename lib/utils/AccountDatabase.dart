import 'package:budget_manager/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/account.dart';
import '../models/transaction.dart';

class DatabaseHelper {
  //ACCOUNT //
  final String _accountTable = "accountTable";
  final String _accColId = "id";
  final String _accColName = "AccountName";
  final String _accColbalance = "AccountBalance";
  final String _accColIconIndex = "IconIndex";
  final String _accColColorIndex = "ColorIndex";
  static Database _database;
/////////////////
//Categories///////
  final String _categoryTable = "categoryTable";
  final String _catColId = "id";
  final String _catColName = "CategoryName";
  final String _catColAmount = "CategoryAmount";
  final String _catColIconIndex = "CategoryIconIndex";
  final String _catColColorIndex = "CategoryColorIndex";
  final String _catType = "CategoryType";
/////////////////
  ///TRANSACTIONS///
  final String _transactionTable = "transactionTable";
  final String _transColId = "id";
  final String _transColdate = "TransactionDate";
  final String _transColFromID = "TransactionFromID";
  final String _transColToType = "TransactionToType";
  final String _transColToID = "TransactionToID";
  final String _transAmount = "TransactionAmount";

  DatabaseHelper() {
    database;
  }
  initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Money.db");
    var myOwnDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myOwnDb;
  }

  // Future<void> deleteTheDatabase() async {
  //   Directory directory = await getApplicationDocumentsDirectory();
  //   await deleteDatabase(join(directory.path, "Money.db")).then((value) async {

  //   }).then((value) => print("database deleted"));
  // }

  _onCreate(Database db, int newVersion) async {
    print("am here");
    await db.execute('''
           CREATE TABLE $_accountTable ($_accColId INTEGER PRIMARY KEY AUTOINCREMENT ,$_accColName TEXT ,$_accColbalance DOUBLE , $_accColColorIndex INTEGER,$_accColIconIndex INTEGER)
          
        ''').then((value) => print("3dt")).catchError((e) {
          print(e);
        });
    await db.execute(''' 
        CREATE TABLE $_transactionTable ($_transColId INTEGER PRIMARY KEY AUTOINCREMENT ,$_transColdate TEXT ,$_transColFromID TEXT , $_transColToType TEXT,$_transColToID TEXT,$_transAmount DOUBLE)
        ''').then((value) => print("3dt tani"));
    await db.execute(''' 
          CREATE TABLE $_categoryTable ($_catColId INTEGER PRIMARY KEY AUTOINCREMENT ,$_catColName TEXT ,$_catColAmount DOUBLE , $_catColColorIndex INTEGER,$_catColIconIndex INTEGER,$_catType TEXT)
        ''').catchError((e) {
      print(e);
    });
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
      return _database;
    }
    return _database;
  }

  Future<void> insertIntotable(Account account) async {
    try {
      await _database
          .insert(_accountTable, account.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .then((value) {
        print("Sucess");
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFromAccountWithId(int id) async {
    try {
      var dbUser = await database;
      return await dbUser.delete(_accountTable,
          where: "$_accColId = ?", whereArgs: [id]).then((value) {
        print("deleted ");
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateAccount(Account account, int id) async {
    var dbUser = await database;
    Map<String, dynamic> row = {
      _accColColorIndex: account.colorIndex,
      _accColIconIndex: account.iconIndex,
      _accColName: account.name,
      _accColbalance: account.balance,
    };
    return await dbUser
        .update(_accountTable, row, where: "$_accColId = ?", whereArgs: [id])
        .then((value) => print("Updated Success"))
        .catchError((e) {
          print(e);
        });
  }

  Future<void> updateAcountAmountOnly(double amount, int id) async {
    var dbUser = await database;
    Map<String, dynamic> row = {
      _accColbalance: amount,
    };
    return await dbUser
        .update(_accountTable, row, where: "$_accColId = ?", whereArgs: [id])
        .then((value) => print("Updated"))
        .catchError((e) {
          print(e);
        });
  }

  Future getAccountById(int id) async {
    var dbUser = await database;
    var sql = "SELECT * FROM $_accountTable WHERE $_accColId = $id ";
    var result = await dbUser.rawQuery(sql);
    if (result.length == 0) {
      return null;
    }
    return Account.fromMap(result.first);
  }

  Future<List<Account>> getAllAccounts() async {
    try {
      final List<Map<String, dynamic>> accounts =
          await _database.query(_accountTable).catchError((e) {
        print(e);
      });
      return List.generate(accounts.length, (index) {
        return Account(
            balance: accounts[index]["AccountBalance"],
            colorIndex: accounts[index]["ColorIndex"],
            name: accounts[index]["AccountName"],
            id: accounts[index]["id"],
            iconIndex: accounts[index]["IconIndex"]);
      });
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////// CATEGORY FUNCTIONS /////////////
  ///
  Future<void> insertIntoCategory(Category category) async {
    try {
      await _database
          .insert(_categoryTable, category.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .then((value) {
        print("Sucess");
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFromCategoryWithId(int id) async {
    try {
      var dbUser = await database;
      return await dbUser.delete(_categoryTable,
          where: "$_catColId = ?", whereArgs: [id]).then((value) {
        print("deleted ");
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Category>> getAllCategories() async {
    try {
      final List<Map<String, dynamic>> categories =
          await _database.query(_categoryTable).catchError((e) {
        print(e);
      });
      return List.generate(categories.length, (index) {
        return Category(
            amount: categories[index]["CategoryAmount"],
            colorIndex: categories[index]["ColorIndex"],
            name: categories[index]["AccountName"],
            id: categories[index]["id"],
            type: categories[index]["CategoryType"],
            iconIndex: categories[index]["IconIndex"]);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCategoryWithId(Category category, int id) async {
    var dbUser = await database;
    Map<String, dynamic> row = {
      _catType: category.type,
      _catColColorIndex: category.colorIndex,
      _catColIconIndex: category.iconIndex,
      _catColName: category.name,
      _catColAmount: category.amount,
    };
    return await dbUser
        .update(_categoryTable, row, where: "$_catColId = ?", whereArgs: [id])
        .then((value) => print("Updated Success"))
        .catchError((e) {
          print(e);
        });
  }

  //////////////////////////////////TRANSACTIONS/////////////
  Future<void> createTranscation(Transactions transaction) async {
    try {
      await _database
          .insert(_transactionTable, transaction.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace)
          .then((value) {
        print("Sucess");
      }).catchError((e) {
        print(e);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Transactions>> fetchTransactions() async {
    try {
      final List<Map<String, dynamic>> transactions =
          await _database.query(_categoryTable).catchError((e) {
        print(e);
      });
      return List.generate(transactions.length, (index) {
        return Transactions(
            amount: transactions[index]["TransactionAmount"],
            date: transactions[index]["TransactionDate"],
            transactingFromId: transactions[index]["TransactionFromID"],
            id: transactions[index]["id"],
            transactingToId: transactions[index]["TransactionToID"],
            transactingToType: transactions[index]["TransactionToType"]);
      });
    } catch (e) {
      print(e);
    }
  }
}
