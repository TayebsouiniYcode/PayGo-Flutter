import '../enums/Kind.dart';

class Transaction {
  String operationRef;
  double amount;
  String kind;
  String createdAt;
  String cin;


  Transaction(
      this.operationRef, this.amount, this.kind, this.createdAt, this.cin);

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(json['operationRef'], json['amount'], json['kind'],
        json['createdAt'], json['cin']);
  }

  @override
  String toString() {
    return "Transaction ref: $operationRef, amount: $amount, kind: $kind, date: $createdAt, cin: $cin";
  }
}
