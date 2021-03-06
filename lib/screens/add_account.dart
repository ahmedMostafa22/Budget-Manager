import 'package:budget_manager/constants.dart';
import 'package:budget_manager/models/account.dart';
import 'package:budget_manager/providers/accounts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddAccount extends StatefulWidget {
  final String screenUseCase;
  final Account account;

  const AddAccount({
    Key key,
    @required this.screenUseCase,
    this.account,
  }) : super(key: key);
  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _form = new GlobalKey<FormState>();
  final _balanceFocusNode = FocusNode();
  var _controllerName = TextEditingController();
  var _controllerBalance = TextEditingController();
  int colorIndex = 1, iconIndex = 1;

  @override
  void initState() {
    super.initState();
    if (widget.screenUseCase == 'Edit') {
      _controllerBalance.text = widget.account.balance.toString();
      _controllerName.text = widget.account.name.toString();
      colorIndex = widget.account.colorIndex;
      iconIndex = widget.account.iconIndex;
    }
  }

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
            onTap: () async {
              if (_saveForm()) {
                Account account = Account(
                    id: widget.screenUseCase == 'Add'
                        ? null
                        : widget.account.id,
                    name: _controllerName.text.toString(),
                    balance: double.parse(_controllerBalance.text.toString()),
                    colorIndex: colorIndex,
                    iconIndex: iconIndex);
                if (widget.screenUseCase == 'Add')
                  await Provider.of<AccountsProvider>(context, listen: false)
                      .addAccount(account);
                else {
                  await Provider.of<AccountsProvider>(context, listen: false)
                      .editAccount(account);
                }
                Fluttertoast.showToast(
                    msg: widget.screenUseCase == 'Add'
                        ? "Account Created Successfully !"
                        : "Account Edited Successfully !",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.of(context).pop();
              }
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
          widget.screenUseCase == 'Add' ? 'New account' : 'Edit account',
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
                decoration: InputDecoration(labelText: 'Account Name'),
                cursorColor: Constants.appBlue,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_balanceFocusNode);
                },
                onChanged: (val) {},
                validator: (val) {
                  if (val.trim().isEmpty) return "Field cant be empty";
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _controllerBalance,
                decoration: InputDecoration(labelText: 'Balance'),
                cursorColor: Constants.appBlue,
                focusNode: _balanceFocusNode,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onChanged: (val) {},
                validator: (val) {
                  if (val.isEmpty ||
                      double.tryParse(val) == null ||
                      double.parse(val) < 0.0)
                    return "Field content is not valid";
                  return null;
                },
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

  bool _saveForm() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      return true;
    }
    return false;
  }
}
