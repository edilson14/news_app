import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  const ArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top,
          bottom: mediaQuery.padding.bottom,
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(article.content),
          ],
        ),
      ),
    );
  }
}
