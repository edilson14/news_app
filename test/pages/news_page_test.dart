import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/providers/news_change_notifier.dart';
import 'package:provider/provider.dart';

import '../services/news_services_test.dart';

void main() {
  late MockNewsServices mockNewsServices;

  setUp(
    () {
      mockNewsServices = MockNewsServices();
    },
  );

  final returnedArticles = [
    Article(title: 'title 1', content: 'content 1'),
    Article(title: 'title 2', content: 'content 2'),
    Article(title: 'title 3', content: 'content 3'),
  ];

  void arrangeNewsServices() {
    when(() => mockNewsServices.getArticles()).thenAnswer(
      (_) async => returnedArticles,
    );
  }

  void arrangeNewsServicesAfter3Seconds() {
    when(() => mockNewsServices.getArticles()).thenAnswer(
      (_) async {
        await Future.delayed(
          const Duration(seconds: 3),
        );
        return returnedArticles;
      },
    );
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsServices),
        child: const NewsPage(),
      ),
    );
  }

  testWidgets(
    'The title is been showed',
    (WidgetTester tester) async {
      arrangeNewsServices();
      await tester.pumpWidget(
        createWidgetUnderTest(),
      );

      expect(find.text('News Pages'), findsOneWidget);
    },
  );

  testWidgets(
    'The loading indicator is displayes while waiting for the articles',
    (WidgetTester tester) async {
      arrangeNewsServicesAfter3Seconds();
      await tester.pumpWidget(
        createWidgetUnderTest(),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();
      // we wait for all animations finished , and then close the tests
    },
  );

  testWidgets(
    'articles are displayed correctly',
    (WidgetTester tester) async {
      arrangeNewsServices();
      await tester.pumpWidget(
        createWidgetUnderTest(),
      );

      await tester.pump();
      for (final article in returnedArticles) {
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
