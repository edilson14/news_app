import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:news_app/models/article_model.dart';

class NewServices {
  final _duration = const Duration(milliseconds: 2);

  // Simular a comunicação com base de dados
  final _articles = List.generate(
    20,
    (_) => Article(
      title: lorem(
        paragraphs: 1,
        words: 3,
      ),
      content: lorem(
        paragraphs: 10,
        words: 500,
      ),
    ),
  );

  Future<List<Article>> getArticles() async {
    await Future.delayed(
      _duration,
    );
    return _articles;
  }
}
