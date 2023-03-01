import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../model/Wallet.dart';
import '../service/WalletService.dart';

class HomePage extends StatelessWidget {
  WalletService walletService = WalletService();
  late Future<Wallet> walletFuture = walletService.fetchWalletByCin("HA194468");
  // Wallet wallet = walletFuture. as Wallet;
  //       .fetchWalletByCin("HA194468");

  HomePage({super.key}) {
    walletFuture = walletService.fetchWalletByCin("HA194468");
    // walletService
    //     .fetchWalletByCin("HA194468")
    //     .then((data) =>  value);

    // print(wallet.toString());
  }

  @override
  Widget build(BuildContext context) {
    // WalletService walletService = new WalletService();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.keyboard_backspace),
        title: const Center(
          child: Text("PayGo"),
        ),
        actions: const [Icon(Icons.notifications_none_outlined)],
      ),
      body: Column(children: [
        Center(
            child: FutureBuilder<Wallet>(
          future: walletFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        )),
      ]),
    );
  }
}
