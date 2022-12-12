import 'package:flutter/material.dart';
import 'package:horizonlabs/models/category_model.dart';
import 'package:provider/provider.dart';

import '../serializers/product.dart';

import '../config/constants.dart';
import '../screens/details_screen.dart';

class ListCardProduct extends StatelessWidget {
  final Product product;
  const ListCardProduct({super.key, required this.product});

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
            Colors.blue.shade100,
          ]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () async {
            if (!context.watch<CategoryModel>().isLoading && !context.watch<CategoryModel>().isError) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CardDetalisScreen(
                          product: product,
                          cats: context.watch<CategoryModel>().allCategories,
                        )),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.toString(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      currencyFormater.format(product.price),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Text(
                      product.category.toString(),
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
