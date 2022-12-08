import 'package:flutter/material.dart';
import 'package:horizonlabs/components/big_credit_card.dart';
import 'package:horizonlabs/serializers/credit_card.dart';

import '../components/dis_user_list.dart';
import '../components/user_card.dart';

class CardDetalisScreen extends StatefulWidget {
  final CreditCard card;
  const CardDetalisScreen({super.key, required this.card});

  @override
  State<CardDetalisScreen> createState() => _CardDetalisScreenState();
}

class _CardDetalisScreenState extends State<CardDetalisScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.card;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Credit Card',
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
                  BigCreditCard(card: card),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 40),
                    child: Text(
                      'Dialogues',
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
                            tabs: const [
                              Text('Loan'),
                              Text('Education'),
                              Text('Personal'),
                              Text('Family'),
                              Text('Work'),
                            ],
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
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: card.users.length,
                          itemBuilder: (context, index) {
                            return UserCards(
                              name: card.users[index].name,
                            );
                          },
                        ),
                        UserCards(
                          name: card.users[0].name,
                        ),
                        Container(),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
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
          body: ListView.separated(
            primary: true,
            itemCount: card.users.length,
            itemBuilder: (context, index) {
              return DismissibleUserTile(
                onDismissed: (direction) {
                  if (mounted) {
                    setState(() {
                      card.users.removeAt(index);
                    });
                  }
                },
                user: card.users[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 2);
            },
          )),
    );
  }
}
