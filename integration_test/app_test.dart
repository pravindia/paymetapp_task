import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horizonlabs/components/big_credit_card.dart';
import 'package:horizonlabs/components/list_card.dart';
import 'package:horizonlabs/config/constants.dart';
import 'package:horizonlabs/models/cards_model.dart';
import 'package:integration_test/integration_test.dart';

import 'package:horizonlabs/main.dart' as app;

void main() {
  setUpAll(() {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  });
  testWidgets("Find widgets and Scrolls", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.byType(BigCreditCard), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byKey(footerText),
      200.0,
      scrollable: find.byType(Scrollable),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(footerText));
    expect(find.byKey(footerText), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byKey(featuredCardKey),
      -200,
      scrollable: find.byType(Scrollable),
    );

    await tester.pumpAndSettle();
  });

  testWidgets("Test add money Button", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    final Finder addWorkoutButton = find.byKey(floatingActionAdd);
    await tester.tap(addWorkoutButton);
    await tester.pumpAndSettle();
  });

  testWidgets('Reorder card lists', (WidgetTester tester) async {
    app.main();
    var originalListItems = CardsModel().getAllCards;
    var listItems = originalListItems;
    await tester.pumpAndSettle();
    expect(listItems, orderedEquals(originalListItems));

    await longPressDrag(
      tester,
      tester.getCenter(find.byKey(const ValueKey("list_2"))),
      tester.getCenter(find.byKey(const ValueKey("list_1"))),
    );
    await tester.pumpAndSettle();
    expect(listItems, orderedEquals(originalListItems));
  });
  testWidgets("Navigate to details screen", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ListCreditCard).first);

    await tester.pumpAndSettle();
    expect(find.byType(BigCreditCard), findsOneWidget);

    await tester.pumpAndSettle();
    await tester.drag(find.byType(Dismissible).first, const Offset(500.0, 0.0));
    await tester.pumpAndSettle();
  });
  testWidgets("Navigate to Profile screen", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(profilePageNav));

    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);
    expect(find.text("Pravin Kumar"), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
  });
  tearDownAll(() {});
}

Future<void> longPressDrag(WidgetTester tester, Offset start, Offset end) async {
  final TestGesture drag = await tester.startGesture(start);
  await tester.pump(kLongPressTimeout + kPressTimeout);
  await drag.moveTo(end);
  await tester.pump(kPressTimeout);
  await drag.up();
}
