import 'package:budget_manager/providers/categories.dart';
import 'package:budget_manager/widgets/category_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseIncomeCategories extends StatefulWidget {
  final String type;

  const ExpenseIncomeCategories({Key key, this.type}) : super(key: key);

  @override
  _ExpenseIncomeCategoriesState createState() =>
      _ExpenseIncomeCategoriesState();
}

class _ExpenseIncomeCategoriesState extends State<ExpenseIncomeCategories> {
  var _future;
  @override
  void initState() {
    super.initState();
    _future = Provider.of<CategoriesProvider>(context, listen: false)
        .getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else
            return ListView(
              children: [
                PieChart(PieChartData(
                    centerSpaceRadius: 50,
                    borderData: FlBorderData(show: false),
                    sections: <PieChartSectionData>[
                      PieChartSectionData(
                          color: Colors.blue,
                          value: 400,
                          showTitle: false,
                          radius: 25)
                    ])),
                Center(
                    child: Text(
                  widget.type == 'Expenses'
                      ? 'Total Expenses : \$ 900'
                      : 'Total Income : \$ 900',
                  style: TextStyle(
                      fontSize: 20,
                      color:
                          widget.type == 'Expenses' ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: width,
                  height: height * 0.5,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4),
                    itemCount: widget.type == 'Expenses'
                        ? categoriesProvider.expenseCategories.length
                        : categoriesProvider.incomeCategories.length,
                    itemBuilder: (context, i) => CategoryItem(
                        category: widget.type == 'Expenses'
                            ? categoriesProvider.expenseCategories[i]
                            : categoriesProvider.incomeCategories[i]),
                  ),
                ),
              ],
            );
        });
  }
}
