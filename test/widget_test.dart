import 'package:flutter_test/flutter_test.dart';
import 'package:aussie_partsfinder/main.dart';

void main() {
  testWidgets('app loads', (tester) async {
    await tester.pumpWidget(const AussiePartsFinderApp());
    expect(find.text('Aussie PartsFinder'), findsOneWidget);
  });
}
