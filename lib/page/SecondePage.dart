import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondePage extends StatelessWidget {
  const SecondePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title 2"),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Page 2"))
        ],
      ),
    );
  }
}
