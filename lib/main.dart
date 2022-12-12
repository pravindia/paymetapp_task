import 'package:flutter/material.dart';
import 'package:horizonlabs/models/cards_model.dart';
import 'package:provider/provider.dart';
import 'models/category_model.dart';
import 'screens/list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ProductModel _productModel = ProductModel();
  final CategoryModel _categoryModel = CategoryModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: MultiProvider(
        // value: ProductModel(),
        providers: [
          ChangeNotifierProvider<ProductModel>.value(value: _productModel),
          ChangeNotifierProvider<CategoryModel>.value(value: _categoryModel),
        ],
        child: Builder(builder: (context) {
          return const MyHomePage();
        }),
      ),
    );
  }
}
