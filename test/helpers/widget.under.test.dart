import 'package:flutter/material.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/providers/news_change_notifier.dart';
import 'package:provider/provider.dart';

import 'helpers.dart';

Widget createWidgetUnderTest({
  required MockNewsServices mockNewsServices,
}) {
  return MaterialApp(
    home: ChangeNotifierProvider(
      create: (_) => NewsChangeNotifier(mockNewsServices),
      child: const NewsPage(),
    ),
  );
}
