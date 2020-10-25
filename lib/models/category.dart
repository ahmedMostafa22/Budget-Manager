class Category {
  int iconIndex, colorIndex;
  String name, type;
  int id;
  double amount;
  Map<String, dynamic> toMap() {
    return {
      "CategoryName": this.name,
      "CategoryAmount": this.amount,
      "CategoryIconIndex": this.iconIndex,
      "CategoryColorIndex": this.colorIndex,
    };
  }

  Category.fromMap(Map<String, dynamic> map) {
    this.name = map["CategoryName"];
    this.amount = map["CategoryAmount"];
    this.iconIndex = map["CategoryIconIndex"];
    this.colorIndex = map["CategoryColorIndex"];
    this.id = map["id"];
    this.type = map["CategoryType"];
  }
  Category(
      {this.id,
      this.iconIndex,
      this.colorIndex,
      this.type,
      this.name,
      this.amount});
}
