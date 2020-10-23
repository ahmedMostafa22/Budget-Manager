import 'package:budget_manager/constants.dart';
import 'package:budget_manager/widgets/wide_btn.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/welcome.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'The best financial manager',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32,backgroundColor: Constants.appWhite),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            WideButton(
              text: 'Get Started',
              function: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyDrawer()));
              },
            ),
            SizedBox(
              height: 16
            )
          ],
        ),
      ),
    );
  }
}
