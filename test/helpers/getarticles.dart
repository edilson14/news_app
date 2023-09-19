import 'package:news_app/models/article_model.dart';

class GetArticles {
  static final List<Article> _returnedArticles = [
    Article(title: 'title 1', content: 'content 1'),
    Article(title: 'title 2', content: 'content 2'),
    Article(title: 'title 3', content: 'content 3'),
  ];

  static List<Article> get returnedArticles => _returnedArticles;
}
