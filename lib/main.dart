import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ruvu_app/auth/login.dart';
import 'package:ruvu_app/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruvu App',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}