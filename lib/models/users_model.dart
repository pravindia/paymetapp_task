import 'package:flutter/material.dart';

import '../serializers/user.dart';
import '../services.dart';

class UsersModel extends ChangeNotifier {
  late List<User> _users;

  bool isLoading = true;
  bool isError = false;

  final ApiService _service = ApiService();

  List<User> get allUsers => _users;

  UsersModel() {
    loadData();
  }

  loadData() async {
    isLoading = true;
    try {
      _users = await _service.getAllUsers();
    } catch (e) {
      isError = true;
    }
    isLoading = false;
    notifyListeners();
  }

  removeUserAt(int index) {
    _users.removeAt(index);
    notifyListeners();
  }
}
