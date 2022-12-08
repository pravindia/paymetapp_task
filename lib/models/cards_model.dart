import 'package:flutter/widgets.dart';
import '../mocks/mock_data.dart';
import '../serializers/credit_card.dart';

class CardsModel extends ChangeNotifier {
  List<CreditCard> _cards = [];
  List<CreditCard> _debitcards = [];
  List<CreditCard> get getAllCards => _cards;
  List<CreditCard> get getAllDebitCards => _debitcards;
  CreditCard getFeaturedCards = CreditCard.fromJson({
    "id": 10,
    "name": "Pravin Kumar",
    "cardnumber": "4041373632645",
    "cardtype": "visa",
    "validtill": "05/23",
    "balance": 23618.98
  });

  CardsModel() {
    loadData();
  }
  loadData() {
    for (var item in mockCreditCards) {
      try {
        _cards.add(CreditCard.fromJson(item));
      } catch (e) {
        rethrow;
      }
    }
    for (var item in mockDebitCards) {
      try {
        _debitcards.add(CreditCard.fromJson(item));
      } catch (e) {
        rethrow;
      }
    }
  }

  void reorderData(int oldindex, int newindex) {
    if (newindex > oldindex) {
      newindex -= 1;
    }
    final items = _cards.removeAt(oldindex);
    _cards.insert(newindex, items);
    notifyListeners();
  }

  void reorderDebitData(int oldindex, int newindex) {
    if (newindex > oldindex) {
      newindex -= 1;
    }
    final items = _cards.removeAt(oldindex);
    _cards.insert(newindex, items);
    notifyListeners();
  }

  addMoney() {
    _cards = _cards.map((element) {
      element.balance += 50;
      return element;
    }).toList();
    _debitcards = _debitcards.map((element) {
      element.balance += 100;
      return element;
    }).toList();
    getFeaturedCards.balance = getFeaturedCards.balance + 10.0;
    notifyListeners();
  }
}
