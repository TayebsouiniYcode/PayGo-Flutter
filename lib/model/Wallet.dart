class Wallet {
  final String cinClient;
  final double balance;
  final double overdraftLimit;
  final bool status;

  const Wallet(this.cinClient, this.balance, this.overdraftLimit, this.status);

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(json['cinClient'], json['balance'], json['overdraftLimit'],
        json['status']);
  }

  @override
  String toString() {
    return "cin: $cinClient, balance: $balance, overdraftLimit: $overdraftLimit, status $status";
  }
}
