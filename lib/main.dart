import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.lightBlueAccent,
      ),
      home: HomePage(),
    );
  }
}
