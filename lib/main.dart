import 'package:flutter/material.dart';
import 'package:horizonlabs/models/cards_model.dart';
import 'package:provider/provider.dart';
import 'screens/list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: ChangeNotifierProvider.value(
        value: CardsModel(),
        child: const MyHomePage(),
      ),
    );
  }
}
