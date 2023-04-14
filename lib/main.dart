import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0xff57b3fe)
    ));
    return const MaterialApp(
      title: 'calculator',
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

