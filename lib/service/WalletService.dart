import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../model/Wallet.dart';

class WalletService {
  String addressIp = "192.168.134.206";
  String cin = "HA121212";

  Future<Wallet> fetchWalletByCin(String _cin) async {
    final response =
        await http.get(Uri.parse('http://$addressIp:8081/api/account/$_cin'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // print(response.body);
      return Wallet.fromJson(jsonDecode(response.body));
      // return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
