import 'package:horizonlabs/serializers/category.dart';

import 'config/constants.dart';
import 'serializers/product.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'serializers/user.dart';

class ApiService {
  Future<List<Product>> getAllProducts() async {
    try {
      final http.Response response = await http.get(Uri.https(
        domain,
        '/products',
      ));
      List<Product> products = [];
      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body['message'] == 'Success' && body['data'].length != 0) {
          for (var product in body['data']) {
            products.add(Product.fromJson(product));
          }
        } else {
          throw Exception(body['message']);
        }
        return products;
      } else {
        throw Exception('Request failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Category>> getAllCategory() async {
    try {
      final http.Response response = await http.get(Uri.https(
        domain,
        '/categories',
      ));
      List<Category> cats = [];
      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body['message'] == 'Success' && body['data'].length != 0) {
          for (var ct in body['data']) {
            cats.add(Category.fromJson(ct));
          }
        } else {
          throw Exception(body['message']);
        }
        return cats;
      } else {
        throw Exception('Request failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      final http.Response response = await http.get(Uri.https(
        domain,
        '/users',
      ));
      List<User> users = [];
      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body['message'] == 'Success' && body['data'].length != 0) {
          for (var usr in body['data']) {
            users.add(User.fromJson(usr));
          }
        } else {
          throw Exception(body['message']);
        }
        return users;
      } else {
        throw Exception('Request failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}
