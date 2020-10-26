import 'package:budget_manager/database/database_helper.dart';
import 'package:budget_manager/models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class CategoriesProvider with ChangeNotifier {
  final String _categoryTable = "categoryTable";
  final String _catColId = "id";
  final String _catColName = "CategoryName";
  final String _catColAmount = "CategoryAmount";
  final String _catColIconIndex = "CategoryIconIndex";
  final String _catColColorIndex = "CategoryColorIndex";
  final String _catType = "CategoryType";

  List<Category> incomeCategories = [];
  List<Category> expenseCategories = [];

  Future<void> addCategory(Category category) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    int res = await _database.insert(_categoryTable, category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    Category categ = Category(
        id: res,
        type: category.type,
        name: category.name,
        amount: category.amount,
        iconIndex: category.iconIndex,
        colorIndex: category.colorIndex);
    if (categ.type == 'Income')
      incomeCategories.add(categ);
    else
      expenseCategories.add(categ);
    notifyListeners();
  }

  Future<void> deleteCategory(int id) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    incomeCategories.removeWhere((element) => element.id == id);
    expenseCategories.removeWhere((element) => element.id == id);
    notifyListeners();
    return _database
        .delete(_categoryTable, where: "$_catColId = ?", whereArgs: [id]);
  }

  getAllCategories() async {
    if (incomeCategories.isEmpty && expenseCategories.isEmpty) {
      DatabaseHelper databaseHelper = DatabaseHelper();
      Database _database = await databaseHelper.database;
      final List<Map<String, dynamic>> categoriesData =
          await _database.query(_categoryTable);
      List<Category> categories = List.generate(categoriesData.length, (index) {
        return Category(
                amount: categoriesData[index]["CategoryAmount"] ,
                colorIndex: categoriesData[index]["ColorIndex"] ,
                name: categoriesData[index]["AccountName"] ,
                id: categoriesData[index]["id"],
                type: categoriesData[index]["CategoryType"] ,
                iconIndex: categoriesData[index]["IconIndex"]) ;
      });
      categories.forEach((element) {
        if (element.type == 'Income')
          incomeCategories.add(element);
        else
          expenseCategories.add(element);
      });
      notifyListeners();
    }
    print(expenseCategories[3].name);
    print('///////////// income count ' + incomeCategories.length.toString());
    print('///////////// expense count ' + expenseCategories.length.toString());
  }

  Future<void> editCategory(Category category, int id) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Database _database = await databaseHelper.database;
    Map<String, dynamic> row = {
      _catType: category.type,
      _catColColorIndex: category.colorIndex,
      _catColIconIndex: category.iconIndex,
      _catColName: category.name,
      _catColAmount: category.amount,
    };
    await _database
        .update(_categoryTable, row, where: "$_catColId = ?", whereArgs: [id]);
    if (category.type == 'Expense')
      for (int i = 0; i < expenseCategories.length; i++)
        if (expenseCategories.elementAt(i).id == category.id) {
          expenseCategories[i] = category;
          break;
        } else
          for (int i = 0; i < incomeCategories.length; i++)
            if (incomeCategories.elementAt(i).id == category.id) {
              incomeCategories[i] = category;
              break;
            }
    notifyListeners();
  }
}
