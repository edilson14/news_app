import 'package:mocktail/mocktail.dart';

import 'helpers.dart';

void arrangeNewsServices(MockNewsServices mockNewsServices) {
  when(() => mockNewsServices.getArticles()).thenAnswer(
    (_) async => GetArticles.returnedArticles,
  );
}

void arrangeNewsServicesAfter3Seconds(MockNewsServices mockNewsServices) {
  when(() => mockNewsServices.getArticles()).thenAnswer(
    (_) async {
      await Future.delayed(
        const Duration(seconds: 3),
      );
      return GetArticles.returnedArticles;
    },
  );
}
