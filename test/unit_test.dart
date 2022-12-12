import 'package:flutter_test/flutter_test.dart';

import 'package:horizonlabs/models/cards_model.dart';
import 'package:horizonlabs/serializers/category.dart';
import 'package:horizonlabs/serializers/product.dart';
import 'package:horizonlabs/services.dart';

void main() {
  group('Unit Test Serializers\n', () {
    group('Test CreditCard: fromJson()', () {
      test("case 1", () {
        var testdata = {
          "_id": '10',
          "title": "Pravin Kumar",
          "price": 2361,
          "description": "4041373632645",
          "slug": "visa",
          "validtill": "05/23",
          'category': {'_id': "12312", 'name': "wdfs asdf", 'slug': "/asdf-asdf"}
        };
        var card = Product.fromJson(testdata);
        expect(card, isNotNull);
        expect(card, isA<Product>());

        expect(card.id, testdata['_id']);
        expect(card.id, isA<String>());
        expect(card.title, testdata['title']);
        expect(card.title, isA<String>());
        expect(card.price, testdata['price']);
        expect(card.price, isA<int>());
      });
      test("case 2", () {
        var testdata2 = {
          "_id": '10',
          "title": "Pravin Kumar",
          "price": 2361.23,
          "description": "4041373632645",
          "slug": "visa",
          "validtill": "05/23",
          'category': {'_id': "12312", 'name': "wdfs asdf", 'slug': "/asdf-asdf"}
        };
        try {
          Product.fromJson(testdata2);
        } catch (e) {
          expect(e, isA<TypeError>());
        }
      });
    });
    group('Test CreditCard: toJson()', () {
      test("case 1", () {
        var testdata = Product(
            category: Category(id: 'catid', name: "men's fashion", slug: "mens-fashion"),
            createdAt: DateTime.now(),
            id: '',
            price: 212,
            title: '',
            updatedAt: DateTime.now());
        var card = testdata.toJson();
        expect(card, isA<Map<String, dynamic>>());
        expect(card, equals(testdata.toJson()));

        expect(card['_id'], equals(testdata.id));
        expect(card['_id'], isA<String>());
        expect(card['title'], equals(testdata.title));
        expect(card['title'], isA<String>());
        expect(card['price'], equals(testdata.price));
        expect(card['price'], isA<int>());
        expect(card['category'], isA<Map<String, dynamic>>());
      });
    });
  });
  group('Unit Test Models\n', () {
    test("Initialise model", () async {
      ProductModel model = ProductModel();

      await Future.doWhile(() async {
        await Future.delayed(const Duration(microseconds: 100));
        return (model.isLoading);
      });
      if (!model.isError) {
        var cards = model.allCards;
        expect(cards, isA<List<Product>>());
        if (cards.isNotEmpty) {
          expect(model.getFeaturedCards, isA<Product>());
          expect(cards.length, 20); // Known value if used pagination
        } else {
          expect(model.getFeaturedCards, equals(null));
        }
      }
    });
    test("Test addMoney function", () async {
      var model = ProductModel();
      await Future.doWhile(() async {
        await Future.delayed(const Duration(microseconds: 100));
        return (model.isLoading);
      });
      var prevBalance = model.getFeaturedCards!.price;

      expect(prevBalance, isA<int>());
      model.addMoney();
      expect(model.getFeaturedCards!.price, prevBalance + 50);
    });
    test("Test reorderData function", () async {
      var model1 = ProductModel();
      var model2 = ProductModel();
      await Future.doWhile(() async {
        await Future.delayed(const Duration(microseconds: 100));
        return (model1.isLoading);
      });
      await Future.doWhile(() async {
        await Future.delayed(const Duration(microseconds: 100));
        return (model2.isLoading);
      });
      if (!model1.isError && !model2.isError) {
        var prevOrderCards = model1.allCards;
        expect(prevOrderCards, isA<List<Product>>());
        expect(prevOrderCards.length, greaterThan(7));
        // Swaping index 5 to 3
        model2.reorderData(5, 3);
        var newOrderCards = model2.allCards;
        expect(prevOrderCards.length, equals(newOrderCards.length));
        // Converting to json as class objects are not same
        expect(newOrderCards[3].toJson(), equals(prevOrderCards[5].toJson()));
        expect(newOrderCards[4].toJson(), equals(prevOrderCards[3].toJson()));
        expect(newOrderCards[5].toJson(), equals(prevOrderCards[4].toJson()));
        expect(newOrderCards[6].toJson(), equals(prevOrderCards[6].toJson()));
      }
    });
  });

  group('Unit Test API Services \n', () {
    test("Test API Service", () async {
      final ApiService service = ApiService();
      try {
        var result = await service.getAllProducts();
        expect(result, isA<List<Product>>());
      } catch (e) {
        expect(e, isException);
      }
    });
  });
}
