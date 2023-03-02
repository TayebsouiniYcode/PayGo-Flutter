import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paygo_flutter/page/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.blue,
            foregroundColor: Color.fromARGB(255, 253, 253, 253),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.blue,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: "PayGo",
        home: HomePage());
  }
}
