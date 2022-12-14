import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:horizonlabs/services.dart';
import '../serializers/product.dart';

class ProductModel extends ChangeNotifier {
  late List<Product> _products;

  bool isLoading = true;
  bool isError = false;

  final ApiService _service = ApiService();

  List<Product> get allCards => _products;
  Product? get getFeaturedCards => (!isError && _products.isNotEmpty) ? _products[0] : null;

  ProductModel() {
    loadData();
  }

  loadData() async {
    isLoading = true;
    notifyListeners();
    try {
      _products = await _service.getAllProducts();
    } catch (e) {
      isError = true;
    }
    isLoading = false;
    notifyListeners();
  }

  void reorderData(int oldindex, int newindex) {
    if (newindex > oldindex) {
      newindex -= 1;
    }
    final items = _products.removeAt(oldindex);
    _products.insert(newindex, items);
    notifyListeners();
  }

  addMoney() {
    _products = _products.map((element) {
      element.price += 50;
      return element;
    }).toList();
    notifyListeners();
  }
}
