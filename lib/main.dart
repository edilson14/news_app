import 'package:flutter/material.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/providers/news_change_notifier.dart';
import 'package:news_app/services/news_services.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewServices()),
        child: const NewsPage(),
      ),
    );
  }
}
