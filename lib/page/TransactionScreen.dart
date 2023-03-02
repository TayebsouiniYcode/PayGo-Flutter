import 'package:flutter/material.dart';
import 'package:paygo_flutter/model/Transaction.dart';
import 'package:paygo_flutter/page/HomePage.dart';
import 'package:paygo_flutter/service/TransactionService.dart';

class TransactionScreen extends StatefulWidget {
  String cin = "";
  TransactionScreen({super.key, cin}) {
    this.cin = cin;
  }

  @override
  State<TransactionScreen> createState() =>
      _TransactionScreenState(cin: this.cin);
}

class _TransactionScreenState extends State<TransactionScreen> {
  double _amount = 0.0;
  String kind = "";
  String cin = "";

  _TransactionScreenState({cin}) {
    this.cin = cin;
  }

  final _formKey = GlobalKey<FormState>();
  TransactionService transactionService = TransactionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // systemOverlayStyle:
          //     SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.keyboard_backspace),
          ),
          title: const Center(
            child: Text("PayGo"),
          ),
          actions: const [Icon(Icons.notifications_none_outlined)],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter amount';
                  } else {
                    this._amount = double.parse(value);
                  }
                  return null;
                },
              ),
              const Text("Kind: (RETRAIT or DEPOSIT)"),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter kind';
                  } else {
                    this.kind = value;
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transaction success'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // print();
                    Transaction transaction = Transaction(
                        "null", this._amount, this.kind, "null", this.cin);
                    transactionService.createTransaction(transaction);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ));
  }
}
