import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/article_page.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/providers/news_change_notifier.dart';
import 'package:provider/provider.dart';

import '../test/services/news_services_test.dart';

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

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsServices),
        child: const NewsPage(),
      ),
    );
  }

  testWidgets(
    'navigate to article details page when news is clicked',
    (WidgetTester widgetTester) async {
      arrangeNewsServices();
      await widgetTester.pumpWidget(
        createWidgetUnderTest(),
      );

      await widgetTester.pump();

      final content = find.text('content 1');

      await widgetTester.tap(content);

      await widgetTester.pumpAndSettle();

      //is not in the news page
      expect(find.byType(NewsPage), findsNothing);
      // is on the article page
      expect(find.byType(ArticlePage), findsOneWidget);

      expect(find.text('title 1'), findsOneWidget);
      expect(find.text('content 1'), findsOneWidget);
    },
  );
}
