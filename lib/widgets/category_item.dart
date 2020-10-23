import 'package:budget_manager/models/category.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(
      {Key key,
      @required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(shape: BoxShape.circle, color: Constants.colors[category.colorIndex]),
          child: Icon(
            Constants.icons[category.iconIndex],
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '\$ ${category.amount.toString()}',
          style: TextStyle(color: Colors.green),
        )
      ],
    );
  }
}
