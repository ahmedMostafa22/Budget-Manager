import 'package:budget_manager/models/category.dart';
import 'package:budget_manager/widgets/category_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseIncomeCategories extends StatelessWidget {
  final String type;

  const ExpenseIncomeCategories({Key key, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        PieChart(PieChartData(
            centerSpaceRadius: 50,
            borderData: FlBorderData(show: false, border: Border()),
            sections: <PieChartSectionData>[
              PieChartSectionData(
                  color: Colors.blue, value: 400, showTitle: false, radius: 25),
              PieChartSectionData(
                  color: Colors.red, value: 60, showTitle: false, radius: 25),
              PieChartSectionData(
                  color: Colors.yellow,
                  value: 100,
                  showTitle: false,
                  radius: 25),
              PieChartSectionData(
                  color: Colors.green,
                  value: 300,
                  showTitle: false,
                  radius: 25),
              PieChartSectionData(
                  color: Colors.grey, value: 100, showTitle: false, radius: 25),
              PieChartSectionData(
                  color: Colors.teal, value: 200, showTitle: false, radius: 25),
              PieChartSectionData(
                  color: Colors.green, value: 50, showTitle: false, radius: 25),
              PieChartSectionData(
                  color: Colors.indigo, value: 90, showTitle: false, radius: 25)
            ])),
        Center(
            child: Text(
          type == 'Expenses'
              ? 'Total Expenses : \$ 900'
              : 'Total Income : \$ 900',
          style: TextStyle(
              fontSize: 20,
              color: type == 'Expenses' ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold),
        )),
        SizedBox(
          height: 8,
        ),
        Container(
          width: width,
          height: height * 0.5,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, crossAxisSpacing: 4, mainAxisSpacing: 4),
            children: [
              CategoryItem(
                category: Category(iconIndex: 9,colorIndex: 11,name: 'Food',amount: 900),
              )
            ],
          ),
        ),
      ],
    );
  }
}
