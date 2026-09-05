import 'package:flutter_test/flutter_test.dart';
import 'package:aplikasi_stok_android/main.dart';

void main() {
  testWidgets('Cek tampilan awal halaman login', (WidgetTester tester) async {
    await tester.pumpWidget(const AplikasiStokApp());
    expect(find.text('Aplikasi Manajemen Gudang'), findsOneWidget);
    expect(find.text('LOGIN MASUK'), findsOneWidget);
  });
}
