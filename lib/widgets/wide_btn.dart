import 'package:budget_manager/constants.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String text;
  final Function function;
  const WideButton({Key key, this.text, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
          width: width / 1.3,
          height: height / 15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Constants.appBlue),
          child: Center(
            child: Text(text,
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Constants.appWhite)),
          )),
    );
  }
}
