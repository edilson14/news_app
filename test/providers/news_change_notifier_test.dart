import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/providers/news_change_notifier.dart';

import '../services/news_services_test.dart';

void main() {
  //stu system under Test
  late NewsChangeNotifier systemUnderTest;
  late MockNewsServices mockNewsServices;

  /// inicializar tudo relativo a testes
  /// para cada teste inicializar um [setUp]
  setUp(() {
    mockNewsServices = MockNewsServices();

    systemUnderTest = NewsChangeNotifier(mockNewsServices);
  });

  test(
    'the variables are corretly initialized',
    () {
      expect(systemUnderTest.articles, []);
      expect(systemUnderTest.isLoading, true);
    },
  );

  group(
    'Get Articles Function',
    () {
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

      test(
        'using the news services',
        () async {
          arrangeNewsServices();
          await systemUnderTest.getArticles();
          verify(() => mockNewsServices.getArticles()).called(1);
        },
      );

      test(
        'the loading status is changing according to data status',
        () async {
          arrangeNewsServices();
          final futureMethod = systemUnderTest.getArticles();
          expect(systemUnderTest.isLoading, true);
          await futureMethod;
          expect(systemUnderTest.isLoading, false);
        },
      );

      test(
        'article list is not empty after calling get articles',
        () async {
          arrangeNewsServices();
          await systemUnderTest.getArticles();
          expect(systemUnderTest.articles.isNotEmpty, true);
        },
      );

      test(
        'the size of articles list is same as returned articles',
        () async {
          arrangeNewsServices();
          await systemUnderTest.getArticles();
          expect(systemUnderTest.articles.length, returnedArticles.length);
        },
      );
    },
  );
}
