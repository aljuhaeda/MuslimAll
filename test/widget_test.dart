import 'package:flutter_test/flutter_test.dart';

import 'package:muslimall_app/main.dart';

void main() {
  testWidgets('Home hub shows greeting and the three section entry points', (WidgetTester tester) async {
    await tester.pumpWidget(const MuslimAllApp());
    await tester.pump();

    expect(find.text("Assalamu'alaikum"), findsOneWidget);
    expect(find.text('Jadwal Sholat'), findsOneWidget);
    expect(find.text('Panduan Sholat'), findsOneWidget);
    expect(find.text("Al-Qur'an"), findsOneWidget);
  });
}
