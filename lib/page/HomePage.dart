import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:paygo_flutter/service/TransactionService.dart';
import 'dart:async';
import 'dart:convert';

import '../model/Transaction.dart';
import '../model/Wallet.dart';
import '../service/WalletService.dart';
import 'TransactionScreen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle:
        //     SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        leading: const Icon(Icons.keyboard_backspace),
        title: const Center(
          child: Text("PayGo"),
        ),
        actions: const [Icon(Icons.notifications_none_outlined)],
      ),
      body: Column(children: [
        Center(child: fetchWallet()),
        SizedBox(
          height: 500,
          child: fetchTransactions(),
        ),
      ]),
    );
  }
}

Widget fetchWallet() {
  WalletService walletService = WalletService();
  late Future<Wallet> walletFuture = walletService.fetchWalletByCin("HA121212");

  Widget walletWidget = FutureBuilder<Wallet>(
    future: walletFuture,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Container(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CIN Client : ${snapshot.data!.cinClient}'),
              Text('Balance : ${snapshot.data!.balance}'),
              Text('overdraftLimit : ${snapshot.data!.overdraftLimit}'),
              Text('Status : ${snapshot.data!.status}'),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionScreen(
                                cin: snapshot.data!.cinClient,
                              )),
                    );
                  },
                  child: Text("Add transaction"),
                ),
              )
            ],
          ),
        );
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return const CircularProgressIndicator();
    },
  );

  return walletWidget;
}

Widget fetchTransactions() {
  TransactionService transactionService = TransactionService();
  late Future<List<Transaction>> transactionFuture =
      transactionService.fetchTransactionByCin("HA121212");

  List<Transaction> transactionList;

  return FutureBuilder<List<Transaction>>(
    future: transactionFuture,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        transactionList = snapshot.data!;
        return ListView.builder(
            itemCount: transactionList == null ? 0 : transactionList.length,
            itemBuilder: (BuildContext context, int index) {
              if (transactionList[index].kind == "DEPOSIT") {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      ' + ${transactionList[index].amount.toString()} MAD',
                      style: TextStyle(color: Colors.green),
                    ),
                    subtitle: Text(transactionList[index].createdAt),
                  ),
                );
              } else {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      ' - ${transactionList[index].amount.toString()} MAD',
                      style: TextStyle(color: Colors.red),
                    ),
                    subtitle: Text(transactionList[index].createdAt),
                  ),
                );
              }
            });
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }
      return const CircularProgressIndicator();
    },
  );
}




// addTransaction() {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 20.0,
//               ),
//             ),
//           ),
//           contentPadding: EdgeInsets.only(
//             top: 10.0,
//           ),
//           title: Text(
//             "Create ID",
//             style: TextStyle(fontSize: 24.0),
//           ),
//           content: Container(
//             height: 400,
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Mension Your ID ",
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Enter Id here',
//                           labelText: 'ID'),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     height: 60,
//                     padding: const EdgeInsets.all(8.0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.black,
//                         // fixedSize: Size(250, 50),
//                       ),
//                       child: Text(
//                         "Submit",
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('Note'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'
//                       ' ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud'
//                       ' exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'
//                       ' Duis aute irure dolor in reprehenderit in voluptate velit esse cillum '
//                       'dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,'
//                       ' sunt in culpa qui officia deserunt mollit anim id est laborum.',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
// }



// showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(
//                                   20.0,
//                                 ),
//                               ),
//                             ),
//                             contentPadding: EdgeInsets.only(
//                               top: 10.0,
//                             ),
//                             title: Text(
//                               "Create ID",
//                               style: TextStyle(fontSize: 24.0),
//                             ),
//                             content: Container(
//                               height: 220,
//                               child: SingleChildScrollView(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: <Widget>[
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         "Mension Your ID ",
//                                       ),
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: TextField(
//                                         decoration: InputDecoration(
//                                             border: OutlineInputBorder(),
//                                             hintText: 'Enter Id here',
//                                             labelText: 'ID'),
//                                       ),
//                                     ),
//                                     Container(
//                                       width: double.infinity,
//                                       height: 60,
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           primary: Colors.black,
//                                           // fixedSize: Size(250, 50),
//                                         ),
//                                         child: Text(
//                                           "Submit",
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );