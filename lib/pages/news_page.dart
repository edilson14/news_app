import 'package:flutter/material.dart';
import 'package:news_app/pages/article_page.dart';
import 'package:news_app/providers/news_change_notifier.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewsPageStatus();
}

class _NewsPageStatus extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NewsChangeNotifier>().getArticles(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Pages'),
      ),
      body: Consumer<NewsChangeNotifier>(
        builder: (builder, notifier, child) {
          if (notifier.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            itemCount: notifier.articles.length,
            itemBuilder: (_, index) {
              final article = notifier.articles[index];
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ArticlePage(article: article),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(article.title),
                    subtitle: Text(
                      article.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
