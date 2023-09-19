import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

void main() {
  late MockNewsServices mockNewsServices;

  setUp(
    () {
      mockNewsServices = MockNewsServices();
    },
  );

  testWidgets(
    'The title is been showed',
    (WidgetTester tester) async {
      arrangeNewsServices(mockNewsServices);
      await tester.pumpWidget(
        createWidgetUnderTest(mockNewsServices: mockNewsServices),
      );

      expect(find.text('News Pages'), findsOneWidget);
    },
  );

  testWidgets(
    'The loading indicator is displayes while waiting for the articles',
    (WidgetTester tester) async {
      arrangeNewsServicesAfter3Seconds(mockNewsServices);
      await tester.pumpWidget(
        createWidgetUnderTest(mockNewsServices: mockNewsServices),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();
      // we wait for all animations finished , and then close the tests
    },
  );

  testWidgets(
    'articles are displayed correctly',
    (WidgetTester tester) async {
      arrangeNewsServices(mockNewsServices);
      await tester.pumpWidget(
        createWidgetUnderTest(mockNewsServices: mockNewsServices),
      );

      await tester.pump();
      for (final article in GetArticles.returnedArticles) {
        expect(
          find.text(article.title),
          findsOneWidget,
        );
        expect(
          find.text(article.content),
          findsOneWidget,
        );
      }
    },
  );
}
