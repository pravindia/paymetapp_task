import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:horizonlabs/serializers/category.dart';
import 'package:horizonlabs/services.dart';

class CategoryModel extends ChangeNotifier {
  late List<Category> _categories;

  bool isLoading = true;
  bool isError = false;

  final ApiService _service = ApiService();

  List<Category> get allCategories => _categories;

  CategoryModel() {
    loadData();
  }

  loadData() async {
    isLoading = true;
    try {
      _categories = await _service.getAllCategory();
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
    final items = _categories.removeAt(oldindex);
    _categories.insert(newindex, items);
    notifyListeners();
  }

  loadAllCatProducts(String slug) async {
    await Future.wait(_categories.map((c) async => await _service.getProductDetails(c.slug)));

    notifyListeners();
  }
}
