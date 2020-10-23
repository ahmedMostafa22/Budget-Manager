import 'package:flutter/material.dart';
import '../constants.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function function;

  const DrawerItem({Key key, this.icon, this.text, this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
          SizedBox(width: 20),
          Text(text,
              style: TextStyle(
                  color: Constants.appWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
      onTap: () {
        function();
      },
    );
  }
}
