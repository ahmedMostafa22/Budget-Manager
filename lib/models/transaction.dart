class Transactions {
  int id;
  String date, transactingFromId, transactingToType, transactingToId;
  double amount;
  Map<String, dynamic> toMap() {
    return {
      "TransactionDate": this.date,
      "TransactionToType": this.transactingToType,
      "TransactionToID": this.transactingToId,
      "TransactionFromID": this.transactingFromId,
      "TransactionAmount": this.amount,
    };
  }

  Transactions.fromMap(Map<String, dynamic> map) {
    this.date = map["TransactionDate"];
    this.transactingToType = map["TransactionToType"];
    this.transactingToId = map["TransactionToID"];
    this.transactingFromId = map["TransactionFromID"];
    this.amount = map["TransactionAmount"];
  }
  Transactions(
      {this.id,
      this.date,
      this.transactingFromId,
      this.transactingToType,
      this.transactingToId,
      this.amount});
}
