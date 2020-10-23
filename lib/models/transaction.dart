class Transaction {
   String id,
      date,
      transactingFromId,
      transactingToType,
      transactingToId;
   double amount;

  Transaction(
      {this.id,
      this.date,
      this.transactingFromId,
      this.transactingToType,
      this.transactingToId,
      this.amount});
}
