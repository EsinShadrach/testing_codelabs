import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_codelabs/main.dart';

void main() {
  group("Main App Test =>", () {
    testWidgets("Favourite Operation test", (widgetTester) async {
      await widgetTester.pumpWidget(const TestingApp());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      for (final iconKey in iconKeys) {
        await widgetTester.tap(
          find.byKey(
            ValueKey(iconKey),
          ),
        );
        await widgetTester.pumpAndSettle(Durations.extralong4);

        expect(
          find.textContaining("Added"),
          findsOne,
          reason:
              "Expected to find a Scaffold with `Added` after pressing the icon with icon key",
        );
      }

      await widgetTester.tap(
        find.byType(FloatingActionButton),
      );
      await widgetTester.pumpAndSettle();

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      for (var rmIconKey in removeIconKeys) {
        await widgetTester.tap(
          find.byKey(
            ValueKey(rmIconKey),
          ),
        );
        await widgetTester.pumpAndSettle(Durations.extralong4);

        expect(
          find.textContaining("Removed"),
          findsOne,
          reason:
              "Expected to find a Scaffold with `Removed` after pressing the icon with icon key",
        );

        await widgetTester.tap(
          find.byType(
            CupertinoActionSheetAction,
          ),
        );
        await widgetTester.pumpAndSettle();
      }
    });
  });
}
