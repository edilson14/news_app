import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/providers/news_change_notifier.dart';

import '../helpers/helpers.dart';

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
      test(
        'using the news services',
        () async {
          arrangeNewsServices(mockNewsServices);
          await systemUnderTest.getArticles();
          verify(() => mockNewsServices.getArticles()).called(1);
        },
      );

      test(
        'the loading status is changing according to data status',
        () async {
          arrangeNewsServices(mockNewsServices);
          final futureMethod = systemUnderTest.getArticles();
          expect(systemUnderTest.isLoading, true);
          await futureMethod;
          expect(systemUnderTest.isLoading, false);
        },
      );

      test(
        'article list is not empty after calling get articles',
        () async {
          arrangeNewsServices(mockNewsServices);
          await systemUnderTest.getArticles();
          expect(systemUnderTest.articles.isNotEmpty, true);
        },
      );

      test(
        'the size of articles list is same as returned articles',
        () async {
          arrangeNewsServices(mockNewsServices);
          await systemUnderTest.getArticles();
          expect(
            systemUnderTest.articles.length,
            GetArticles.returnedArticles.length,
          );
        },
      );
    },
  );
}
