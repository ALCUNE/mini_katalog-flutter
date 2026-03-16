import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniKatalogApp());
    expect(find.text('Mini Katalog'), findsOneWidget);
  });
}
