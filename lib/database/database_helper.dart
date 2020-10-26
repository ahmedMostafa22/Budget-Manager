import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String _accountTable = "accountTable";
  final String _accColId = "id";
  final String _accColName = "AccountName";
  final String _accColbalance = "AccountBalance";
  final String _accColIconIndex = "IconIndex";
  final String _accColColorIndex = "ColorIndex";
  final String _transactionTable = "transactionTable";
  final String _transColId = "id";
  final String _transColdate = "TransactionDate";
  final String _transColFromID = "TransactionFromID";
  final String _transColToType = "TransactionToType";
  final String _transColToID = "TransactionToID";
  final String _transAmount = "TransactionAmount";
  final String _categoryTable = "categoryTable";
  final String _catColId = "id";
  final String _catColName = "CategoryName";
  final String _catColAmount = "CategoryAmount";
  final String _catColIconIndex = "CategoryIconIndex";
  final String _catColColorIndex = "CategoryColorIndex";
  final String _catType = "CategoryType";
  static Database _database;

  DatabaseHelper() {
    database;
  }
  initializedDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "Money.db");
    var myOwnDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return myOwnDb;
  }

  _onCreate(Database db, int newVersion) async {
    await db.execute('''
           CREATE TABLE $_accountTable ($_accColId INTEGER PRIMARY KEY AUTOINCREMENT ,$_accColName TEXT ,$_accColbalance DOUBLE , $_accColColorIndex INTEGER,$_accColIconIndex INTEGER)
        ''');
    await db.execute(''' 
        CREATE TABLE $_transactionTable ($_transColId INTEGER PRIMARY KEY AUTOINCREMENT ,$_transColdate TEXT ,$_transColFromID TEXT , $_transColToType TEXT,$_transColToID TEXT,$_transAmount DOUBLE)
        ''');
    await db.execute(''' 
          CREATE TABLE $_categoryTable ($_catColId INTEGER PRIMARY KEY AUTOINCREMENT ,$_catColName TEXT ,$_catColAmount DOUBLE , $_catColColorIndex INTEGER,$_catColIconIndex INTEGER,$_catType TEXT)
        ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
      return _database;
    }
    return _database;
  }
}
