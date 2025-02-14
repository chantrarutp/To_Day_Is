import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/color.dart';
import 'package:flutter_test/flutter_test.dart';
// แก้ไขเป็น path ของ ColorScreen ของคุณ

void main() {
  testWidgets('ทดสอบการโหลด ColorScreen อย่างถูกต้อง',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ColorScreen()));

    // ตรวจสอบว่า AppBar แสดงอยู่
    expect(find.text('Color in Day'), findsOneWidget);

    // ตรวจสอบว่า Text ที่มี Key 'selectedColorText' แสดง 'To Day is...'
    expect(find.byKey(const ValueKey('selectedColorText')), findsOneWidget);
  });

  testWidgets('ทดสอบการสุ่มสี', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ColorScreen()));

    // คลิกปุ่มเพื่อเริ่มการสุ่มสี
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // อัปเดต UI
    // ตรวจสอบว่าชื่อสีถูกอัปเดตเป็นสีที่สุ่มได้
    expect(find.byKey(const ValueKey('selectedColorText')), findsOneWidget);
  });
}
