import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:horizonlabs/serializers/credit_card.dart';
import 'package:provider/provider.dart';

import '../components/big_credit_card.dart';
import '../components/list_card.dart';

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
        onPressed: context.read<CardsModel>().addMoney,
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
                BigCreditCard(key: featuredCardKey, card: context.watch<CardsModel>().getFeaturedCards),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Credit Cards',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Consumer<CardsModel>(
            builder: (_, model, __) {
              final List<CreditCard> item = model.getAllCards;
              return SliverReorderableList(
                itemBuilder: (BuildContext context, int index) {
                  return ReorderableDelayedDragStartListener(
                    enabled: true,
                    key: ValueKey(index),
                    index: index,
                    child: ListCreditCard(
                      key: ValueKey("list_${item[index].id}"),
                      card: item[index],
                    ),
                  );
                },
                itemCount: model.getAllCards.length,
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
                    'Debit Cards',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Consumer<CardsModel>(
            builder: (_, model, __) {
              final List<CreditCard> item = model.getAllDebitCards;
              return SliverReorderableList(
                itemBuilder: (BuildContext context, int index) {
                  return ReorderableDelayedDragStartListener(
                    enabled: true,
                    key: ValueKey(index),
                    index: index,
                    child: ListCreditCard(
                      key: ValueKey("list_${item[index].id}"),
                      card: item[index],
                    ),
                  );
                },
                itemCount: item.length,
                onReorder: model.reorderDebitData,
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
