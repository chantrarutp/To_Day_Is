import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/num.dart';
import 'package:flutter_application_1/screen/LocaleProvidelanguage_provider.dart';

void main() {
  group('Number Randomizer Tests', () {
    testWidgets('Button is disabled during randomization',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
          child: const MaterialApp(home: NumberScreen()),
        ),
      );

      // ใส่ค่าที่ถูกต้องลงในฟิลด์
      await tester.enterText(find.byType(TextField).at(0), '1');
      await tester.enterText(find.byType(TextField).at(1), '10');

      // กดปุ่มเพื่อเริ่มการสุ่ม
      await tester.tap(find.text('To Day is...'));
      await tester.pump(); // เริ่มแอนิเมชันและสถานะการโหลด

      // ตรวจสอบว่าปุ่มถูกปิดการใช้งานในช่วงการสุ่ม
      expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
          isFalse);

      // Fast-forward จนการสุ่มเสร็จสิ้น (ใช้เวลาประมาณ 3 วินาที)
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle(); // รอให้ทุกอย่าง settle ก่อน

      // ตรวจสอบว่าปุ่มกลับมาเปิดใช้งานได้หลังจากสุ่มเสร็จ
      expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
          isTrue);
    });

    testWidgets('Should show SnackBar when from >= to',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
          child: const MaterialApp(home: NumberScreen()),
        ),
      );

      // ใส่ค่าที่ไม่ถูกต้อง
      await tester.enterText(find.byType(TextField).at(0), '10');
      await tester.enterText(find.byType(TextField).at(1), '5');

      // กดปุ่มเพื่อสุ่ม
      await tester.tap(find.text('To Day is...'));

      // ใช้ pumpAndSettle เพื่อรอให้การแสดง SnackBar เสร็จสิ้น
      await tester.pumpAndSettle();

      // ตรวจสอบว่ามี SnackBar ที่มีข้อความแสดงอยู่
      expect(find.textContaining('Please ensure'), findsOneWidget);
    });
  });
}
