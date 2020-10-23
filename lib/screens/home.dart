import 'package:budget_manager/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import '../constants.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.appWhite,
        title: Text('Overview',style: TextStyle(color: Constants.appBlue,),),
        leading: InkWell(
            onTap: () {
              openDrawer();
            },
            child: Icon(Icons.menu,color: Constants.appBlue,)),
      ),
      body: Container(
        color: Constants.appWhite,
      ),
    );
  }
}

final GlobalKey<InnerDrawerState> _innerDrawerKey =
    GlobalKey<InnerDrawerState>();

void openDrawer() {
  _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
}

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: true,
        swipe: true,
        colorTransitionChild: Constants.appWhite,
        scale: IDOffset.horizontal(0.8),
        borderRadius: 50,
        rightAnimationType: InnerDrawerAnimation.quadratic,
        leftAnimationType: InnerDrawerAnimation.quadratic,
        backgroundDecoration: BoxDecoration(color: Constants.appBlue),
        onDragUpdate: (double val, InnerDrawerDirection direction) {},
        innerDrawerCallback: (a) {},
        leftChild: DrawerMenu(),
        rightChild: DrawerMenu(),
        scaffold: Home());
  }
}
