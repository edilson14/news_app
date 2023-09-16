import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/providers/news_change_notifier.dart';

import '../services/news_services_test.dart';

void main() {
  //stu system under Test
  late NewsChangeNotifier stu;
  late MockNewsServices mockNewsServices;

  /// inicializar tudo relativo a testes
  /// para cada teste inicializar um [setUp]
  setUp(() {
    mockNewsServices = MockNewsServices();

    stu = NewsChangeNotifier(mockNewsServices);
  });

  test(
    'verificar se as variaveis estão sendo inicializados da forma correta',
    () {
      expect(stu.articles, []);
      expect(stu.isLoading, true);
    },
  );

  group(
    'Função get articles',
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
        'função getArticle usando a news services',
        () async {
          arrangeNewsServices();
          await stu.getArticles();
          verify(() => mockNewsServices.getArticles()).called(1);
        },
      );

      test(
        'indicar o loading dos dados e que eles chegaram e logo depois garantir que nao estao sendo carregados',
        () async {
          arrangeNewsServices();
          final futureMethod = stu.getArticles();
          expect(stu.isLoading, true);
          await futureMethod;
          expect(stu.articles, returnedArticles);
          expect(stu.isLoading, false);
        },
      );
    },
  );
}
