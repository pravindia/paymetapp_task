import 'package:flutter/material.dart';
import 'package:horizonlabs/serializers/credit_card.dart';

import '../config/constants.dart';
import '../screens/details_screen.dart';

class ListCreditCard extends StatelessWidget {
  final CreditCard card;
  const ListCreditCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            Colors.white,
            Colors.white,
            Colors.white,
            card.getColor(),
          ]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CardDetalisScreen(card: card)),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currencyFormater.format(card.balance),
                style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card.cardtype.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                  ),
                  Flexible(
                    child: Text(
                      'XXXX XXXX XXXX ${card.cardnumber.substring(card.cardnumber.length - 4)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
