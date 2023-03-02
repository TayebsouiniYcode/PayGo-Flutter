import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

import '../model/Transaction.dart';

class TransactionService {
  String addressIp = "192.168.134.206";
  String cin = "HA121212";

  Future<List<Transaction>> fetchTransactionByCin(String _cin) async {
    final response = await http
        .get(Uri.parse('http://192.168.134.206:8082/api/transaction/$_cin'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      // print(response.body);
      List<dynamic> body = jsonDecode(response.body);
      List<Transaction> transactionList =
          body.map((dynamic item) => Transaction.fromJson(item)).toList();
      return transactionList;
      // return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<String> createTransaction(Transaction transaction) async {
    Map data = {
      'amount': transaction.amount,
      'kind': transaction.kind,
      'cin': transaction.cin,
    };

    print(transaction);

    final Response response = await post(
      Uri.parse('http://192.168.134.206:8082/api/transaction'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return "success";
    } else {
      throw Exception('Failed to post transaction');
    }
  }
}
