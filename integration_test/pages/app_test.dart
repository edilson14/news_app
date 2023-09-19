import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/pages/pages.dart';

import '../../test/helpers/helpers.dart';

void main() {
  late MockNewsServices mockNewsServices;

  setUp(
    () {
      mockNewsServices = MockNewsServices();
    },
  );

  testWidgets(
    'navigate to article details page when news is clicked',
    (WidgetTester widgetTester) async {
      arrangeNewsServices(mockNewsServices);
      await widgetTester.pumpWidget(
        createWidgetUnderTest(mockNewsServices: mockNewsServices),
      );

      await widgetTester.pump();

      final content = find.text('content 1');

      await widgetTester.tap(content);

      await widgetTester.pumpAndSettle();

      //is not in the news page
      expect(find.byType(NewsPage), findsNothing);
      // is on the article page
      expect(find.byType(ArticlePage), findsOneWidget);

      expect(find.text('title 1'), findsOneWidget);
      expect(find.text('content 1'), findsOneWidget);
    },
  );
}
