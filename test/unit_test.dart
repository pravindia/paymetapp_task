import 'package:flutter_test/flutter_test.dart';
import 'package:horizonlabs/mocks/mock_data.dart';
import 'package:horizonlabs/models/cards_model.dart';
import 'package:horizonlabs/serializers/credit_card.dart';

void main() {
  group('Unit Test Serializers\n', () {
    group('Test CreditCard: fromJson()', () {
      test("case 1", () {
        var testdata = {
          "id": 10,
          "name": "Pravin Kumar",
          "cardnumber": "4041373632645",
          "cardtype": "visa",
          "validtill": "05/23",
          "balance": 23618.98
        };
        var card = CreditCard.fromJson(testdata);
        expect(card, isNotNull);
        expect(card, isA<CreditCard>());

        expect(card.id, testdata['id']);
        expect(card.id, isA<int>());
        expect(card.name, testdata['name']);
        expect(card.name, isA<String>());
        expect(card.balance, testdata['balance']);
        expect(card.balance, isA<double>());
      });
      test("case 2", () {
        var testdata2 = {
          "id": 10,
          "name": "Pravin Kumar",
          "cardnumber": '4041373632645',
          "cardtype": "visa",
          "validtill": "05/23",
          "balance": 0
        };
        try {
          CreditCard.fromJson(testdata2);
        } catch (e) {
          expect(e, isA<TypeError>());
        }
      });
    });
    group('Test CreditCard: toJson()', () {
      test("case 1", () {
        var testdata = CreditCard(
          users: [],
          balance: 1222,
          cardnumber: '',
          id: 12,
          name: 'Test',
          cardtype: '',
          validtill: '',
        );
        var card = testdata.toJson();
        expect(card, isA<Map<String, dynamic>>());
        expect(card, equals(testdata.toJson()));

        expect(card['id'], equals(testdata.id));
        expect(card['id'], isA<int>());
        expect(card['name'], equals(testdata.name));
        expect(card['name'], isA<String>());
        expect(card['balance'], equals(testdata.balance));
        expect(card['balance'], isA<double>());
        expect(card['users'], isA<List>());
      });
    });
  });
  group('Unit Test Models\n', () {
    test("Initialise model", () {
      var model = CardsModel();
      var cards = model.getAllCards;
      expect(cards, isA<List<CreditCard>>());
      expect(model.getFeaturedCards, isA<CreditCard>());

      // pass if all json parsed correctly
      expect(cards.length, mockCreditCards.length);
    });
    test("Test addMoney function", () {
      var model = CardsModel();
      var prevBalance = model.getFeaturedCards.balance;

      expect(prevBalance, isA<double>());
      model.addMoney();
      expect(model.getFeaturedCards.balance, prevBalance + 10);
    });
    test("Test reorderData function", () {
      var model = CardsModel();
      var prevOrderCards = CardsModel().getAllCards;
      expect(prevOrderCards, isA<List<CreditCard>>());
      expect(prevOrderCards.length, greaterThan(7));
      // Swaping index 5 to 3
      model.reorderData(5, 3);
      var newOrderCards = model.getAllCards;
      expect(prevOrderCards.length, equals(newOrderCards.length));
      // Converting to json as class objects are not same
      expect(newOrderCards[3].toJson(), equals(prevOrderCards[5].toJson()));
      expect(newOrderCards[4].toJson(), equals(prevOrderCards[3].toJson()));
      expect(newOrderCards[5].toJson(), equals(prevOrderCards[4].toJson()));
      expect(newOrderCards[6].toJson(), equals(prevOrderCards[6].toJson()));
    });
  });
}
