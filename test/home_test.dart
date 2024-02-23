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
  });
}
