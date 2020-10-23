import 'package:flutter/material.dart';

import '../constants.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _form = new GlobalKey<FormState>();
  var _controllerName = TextEditingController();
  int colorIndex = 1, iconIndex = 1;
  String categoryType='Expense';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Constants.appBlue),
        backgroundColor: Constants.appWhite,
        actions: [
          InkWell(
            onTap: () {
              _saveForm();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.check,
                color: Constants.appBlue,
              ),
            ),
          )
        ],
        title: Text(
          'New category',
          style: TextStyle(
            color: Constants.appBlue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              TextFormField(
                controller: _controllerName,
                decoration: InputDecoration(labelText: 'Category Name'),
                cursorColor: Constants.appBlue,
                textInputAction: TextInputAction.next,
                onChanged: (val) {},
                validator: (val) {
                  if (val.trim().isEmpty) return "Field cant be empty";
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Radio(
                          value: 'Expense',
                          groupValue: categoryType,
                          onChanged: (val) {
                            setState(() {
                              categoryType = val;
                            });
                          }),
                      Text('Expense')
                    ],
                  ),
                  Column(
                    children: [
                      Radio(
                          value: 'Income',
                          groupValue: categoryType,
                          onChanged: (val) {
                            setState(() {
                              categoryType = val;
                            });
                          }),
                      Text('Income')
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white10,
                          builder: (context) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(30),
                                        topStart: Radius.circular(30))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Pick account color',
                                      style: TextStyle(
                                          color: Constants.appBlue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: width * 0.8,
                                      height: height * 0.4,
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10),
                                        itemBuilder: (context, i) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              colorIndex = i;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Constants.colors[i]),
                                            child: colorIndex == i
                                                ? Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  )
                                                : null,
                                          ),
                                        ),
                                        itemCount: Constants.colors.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constants.colors[colorIndex]),
                      child: Text(
                        'Color',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.white10,
                          context: context,
                          builder: (context) => Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(30),
                                        topStart: Radius.circular(30))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Pick account icon',
                                      style: TextStyle(
                                          color: Constants.appBlue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: width * 0.8,
                                      height: height * 0.4,
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10),
                                        itemBuilder: (context, i) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              iconIndex = i;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Constants
                                                    .colors[colorIndex]),
                                            child: Icon(
                                              Constants.icons[i],
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        itemCount: Constants.icons.length,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(28),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constants.colors[colorIndex]),
                      child: Icon(
                        Constants.icons[iconIndex],
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
    }
  }
}
