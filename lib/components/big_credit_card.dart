import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../serializers/product.dart';

class BigCreditCard extends StatelessWidget {
  const BigCreditCard({super.key, required this.product});
  final Product? product;

  @override
  Widget build(BuildContext context) {
    if (product == null) return Container();
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 10),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.yellow.shade300],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  product!.toString(),
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                ),
              ),
              Text(
                currencyFormater.format(product!.price),
                overflow: TextOverflow.visible,
                maxLines: 1,
                style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/chip.png',
                      width: 40,
                    ),
                    Text(
                      product!.category.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Created At',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    dateformter.format(product?.createdAt ?? DateTime.now()),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "- by ${product?.createdBy?.name}",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
