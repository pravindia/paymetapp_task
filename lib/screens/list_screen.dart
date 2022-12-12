import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:horizonlabs/components/list_card_category.dart';
import 'package:horizonlabs/models/category_model.dart';
import 'package:horizonlabs/serializers/category.dart';
import 'package:horizonlabs/serializers/product.dart';
import 'package:provider/provider.dart';

import '../components/big_credit_card.dart';
import '../components/empty_widget.dart';
import '../components/list_card_product.dart';

import '../components/loading_widget.dart';
import '../components/error_widget.dart';
import '../config/constants.dart';
import '../models/cards_model.dart';
import 'profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'LouBank',
          style: GoogleFonts.montserrat().copyWith(color: Colors.amber),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 10, bottom: 2),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
          child: InkWell(
            key: profilePageNav,
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Image.asset(
              'images/user.jpeg',
              height: 50,
              width: 50,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: floatingActionAdd,
        backgroundColor: Colors.amber,
        onPressed: context.read<ProductModel>().addMoney,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (!context.watch<ProductModel>().isLoading && !context.watch<ProductModel>().isError)
                  BigCreditCard(key: featuredCardKey, product: context.read<ProductModel>().getFeaturedCards),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Products',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Consumer<ProductModel>(
            builder: (_, model, __) {
              if (model.isLoading) return const LoadingWidget();
              if (model.isError) {
                return ErrorsWidget(onPressed: () async {
                  await model.loadData();
                });
              }

              final List<Product> item = model.allCards;
              if (item.isEmpty) return const EmptyDataWidget(data: 'No data');
              return SliverReorderableList(
                itemBuilder: (BuildContext context, int index) {
                  return ReorderableDelayedDragStartListener(
                    enabled: true,
                    key: ValueKey(index),
                    index: index,
                    child: ListCardProduct(
                      key: ValueKey("list_$index"),
                      product: item[index],
                    ),
                  );
                },
                itemCount: model.allCards.length,
                onReorder: model.reorderData,
              );
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Consumer<CategoryModel>(
            builder: (_, model, __) {
              if (model.isLoading) return const LoadingWidget();
              if (model.isError) return ErrorsWidget(onPressed: model.loadData);

              final List<Category> item = model.allCategories;
              if (item.isEmpty) return const EmptyDataWidget(data: 'No data');
              return SliverReorderableList(
                itemBuilder: (BuildContext context, int index) {
                  return ReorderableDelayedDragStartListener(
                    enabled: true,
                    key: ValueKey(index),
                    index: index,
                    child: ListCardCategory(
                      key: ValueKey("cat_${item[index].id}"),
                      category: item[index],
                    ),
                  );
                },
                itemCount: item.length,
                onReorder: model.reorderData,
              );
            },
          ),
          const SliverToBoxAdapter(
            child: Text('Thanks for using our App', key: footerText, textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
