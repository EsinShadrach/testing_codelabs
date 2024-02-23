import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelabs/models/favourites.dart';
import 'package:testing_codelabs/screens/favourite.dart';

late Favourite favoritesList;
Widget createFavouriteScreen() => ChangeNotifierProvider<Favourite>(
      create: (context) {
        favoritesList = Favourite();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavouriteScreen(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i++) {
    favoritesList.add(i);
  }
}

void main() {
  group("Favourite Page Test =>", () {
    testWidgets("Find ListView", (widgetTester) async {
      await widgetTester.pumpWidget(createFavouriteScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets("Remove Button", (widgetTester) async {
      await widgetTester.pumpWidget(createFavouriteScreen());
      addItems();
      await widgetTester.pumpAndSettle();

      int totalItems = widgetTester.widgetList(find.byIcon(Icons.close)).length;
      expect(
        totalItems,
        10,
        reason: "Expected to find `10` widgets after `addItems()`",
      );

      await widgetTester.tap(find.byIcon(Icons.close).first);
      await widgetTester.pumpAndSettle();

      expect(
        widgetTester.widgetList(find.byIcon(Icons.close)).length,
        lessThan(totalItems),
        reason:
            "after one close icon has been pressed then total count of widgets with closeIcon is meant to reduce",
      );

      expect(
        find.textContaining("Remove"),
        findsOneWidget,
        reason:
            "After you remove an icon a cupertino poppu sheet is meant to pop up with the text `Removed from favorites`",
      );
    });
  });
}
