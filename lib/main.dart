import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/model/balance.dart';
import 'package:hive_test/ui/pages/main_page.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BalanceAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}
