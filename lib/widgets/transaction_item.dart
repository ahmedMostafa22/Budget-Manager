import 'package:flutter/material.dart';

import '../constants.dart';

class TransactionItem extends StatefulWidget {
  final Color iconBackgroundColor;
  final IconData categoryIcon, accountIcon;
  final String transactedToName, accountName;
  final double transactionAmount;

  const TransactionItem(
      {Key key,
      @required this.iconBackgroundColor,
      @required this.categoryIcon,
      @required this.transactedToName,
      @required this.transactionAmount,
      @required this.accountIcon,
      @required this.accountName})
      : super(key: key);
  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
              width: 45,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.iconBackgroundColor,
              ),
              child: Icon(widget.categoryIcon, color: Constants.appWhite)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.transactedToName),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(widget.accountIcon, color: Colors.grey),
                  Text(
                    widget.accountName,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          trailing: Text(
            '\$${widget.transactionAmount.toString()}',
            style: TextStyle(color: Color(0xFF00C853), fontSize: 18),
          ),
        ),
        Divider()
      ],
    );
  }
}
