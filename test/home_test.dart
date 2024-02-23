import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_codelabs/models/favourites.dart';
import 'package:testing_codelabs/screens/home.dart';

Widget createHomeScreen() => ChangeNotifierProvider<Favourite>(
      create: (context) => Favourite(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );

void main() {
  group("Home Page Test => ", () {
    testWidgets("ListView Exists", (widgetTester) async {
      await widgetTester.pumpWidget(
        createHomeScreen(),
      );

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets("Test Scrolling", (tester) async {
      await tester.pumpWidget(
        createHomeScreen(),
      );

      expect(find.text("Item 0"), findsOneWidget);

      await tester.fling(
        find.byType(ListView),
        const Offset(0, -200),
        3000,
      );

      await tester.pumpAndSettle();

      expect(find.text("Item 0"), findsNothing);
    });

    testWidgets("Test for AddingIcon", (widgetTester) async {
      await widgetTester.pumpWidget(createHomeScreen());

      // We don't expect to find any already selected cause this is start an in the start nothing is selected
      expect(find.byIcon(Icons.favorite), findsNothing);

      await widgetTester.tap(find.byIcon(Icons.favorite_border).first);
      await widgetTester.pumpAndSettle(Durations.extralong4);

      expect(
        find.textContaining("Added"),
        findsOneWidget,
        reason: "Failed To find text containting `Added` in the widget tree",
      );

      // Since we've added above we can handle a Icons.favorite
      expect(find.byIcon(Icons.favorite), findsWidgets);
      await widgetTester.tap(find.byIcon(Icons.favorite).first);
      await widgetTester.pumpAndSettle(Durations.extralong4);
      expect(
        find.textContaining("Removed"),
        findsOneWidget,
        reason: "Failed To find text containting `Removed` in the widget tree",
      );

      expect(
        find.byIcon(Icons.favorite),
        findsNothing,
        reason:
            "Failed to find icon for `favourite` in widget tree after removal",
      );
    });
  });
}
