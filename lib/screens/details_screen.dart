import 'package:flutter/material.dart';

import 'package:horizonlabs/serializers/category.dart';
import '../models/users_model.dart';
import 'package:provider/provider.dart';
import '../components/big_credit_card.dart';
import '../serializers/user.dart';
import '../serializers/product.dart';
import '../components/dis_user_list.dart';
import '../components/user_card.dart';

class CardDetalisScreen extends StatefulWidget {
  final Product product;
  final List<Category> cats;
  const CardDetalisScreen({super.key, required this.product, required this.cats});

  @override
  State<CardDetalisScreen> createState() => _CardDetalisScreenState();
}

class _CardDetalisScreenState extends State<CardDetalisScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final List<Category> cats;

  final UsersModel _model = UsersModel();

  @override
  void initState() {
    cats = widget.cats;
    _tabController = TabController(length: cats.length, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BigCreditCard(product: card),
                  if (cats.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 40),
                      child: Text(
                        'Categories',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TabBar(
                              controller: _tabController,
                              isScrollable: true,
                              labelPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                              indicator: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.amber),
                              automaticIndicatorColorAdjustment: true,
                              tabs: [...cats.map((e) => Text(e.toString()))],
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.tune))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          for (var c in cats)
                            ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: c.products?.length,
                              itemBuilder: (context, index) {
                                return UserCards(
                                  name: c.products![index],
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 40),
                    child: Text(
                      'Messages',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ))
            ];
          },
          body: ChangeNotifierProvider.value(
            value: _model,
            child: Consumer<UsersModel>(builder: (_, model, __) {
              if (model.isLoading) return const Center(child: CircularProgressIndicator());
              if (model.isError) return const Text("Error");

              final List<User> item = model.allUsers;
              if (item.isEmpty) return const Text('No users found');
              return ListView.separated(
                primary: true,
                itemCount: model.allUsers.length,
                itemBuilder: (context, index) {
                  return DismissibleUserTile(
                    onDismissed: (direction) {
                      model.removeUserAt(index);
                    },
                    user: model.allUsers[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 2);
                },
              );
            }),
          )),
    );
  }
}
