import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Function function;
  final String text;
  const CircularIconButton(
      {Key key, this.color, this.icon, this.function, this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: () {
            function();
          },
          child: Container(
              width: width * 0.15,
              height: width * 0.15,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              )),
        ),
        SizedBox(
          height: 4,
        ),
        Text(text)
      ],
    );
  }
}
