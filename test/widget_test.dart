
import 'package:flutter_test/flutter_test.dart';
import 'package:ragamnusa/main.dart';

void main() {
  testWidgets('RAGAMNUSA app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const RagamNusaApp());

    expect(find.text('RAGAMNUSA'), findsWidgets);
  });
}
