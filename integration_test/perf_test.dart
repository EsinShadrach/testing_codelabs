import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:testing_codelabs/main.dart';

void main() {
  group("Perfomance Test =>", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets("Scrolling Test", (widgetTester) async {
      await widgetTester.pumpWidget(const TestingApp());
      final listFinder = find.byType(ListView);

      await binding.traceAction(
        () async {
          await widgetTester.fling(listFinder, const Offset(0, -500), 10000);
          await widgetTester.pumpAndSettle();

          await widgetTester.fling(listFinder, const Offset(0, 500), 10000);
          await widgetTester.pumpAndSettle();
        },
        reportKey: 'scrolling_summary',
      );
    });
  });
}
