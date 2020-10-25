class Account {
  String name;
  int id;
  double balance;
  int iconIndex, colorIndex;

  Account({this.id, this.name, this.balance, this.iconIndex, this.colorIndex});
  Map<String, dynamic> toMap() {
    return {
      "AccountName": this.name,
      "AccountBalance": this.balance,
      "IconIndex": this.iconIndex,
      "ColorIndex": this.colorIndex,
    };
  }

  Account.fromMap(Map<String, dynamic> map) {
    this.name = map["AccountName"];
    this.balance = map["AccountBalance"];
    this.iconIndex = map["IconIndex"];
    this.colorIndex = map["ColorIndex"];

    this.id = map["id"];
  }
  
}
