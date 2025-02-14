import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/spinwheel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Add option to options list', (WidgetTester tester) async {
    // สร้างหน้า SpinWheelScreen ขึ้นมา
    await tester.pumpWidget(const MaterialApp(
      home: SpinWheelScreen(),
    ));

    // ตรวจสอบว่าไม่มีตัวเลือกเริ่มต้น
    expect(find.text('Option 1'), findsNothing);

    // หา TextField และใส่ค่าลงไป
    await tester.enterText(find.byType(TextField), 'Option 1');

    // กดปุ่มเพิ่ม
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // รอให้ UI อัปเดต

    // ตรวจสอบว่าตัวเลือกถูกเพิ่มเข้าชุด options หรือไม่
    expect(find.text('Option 1'), findsOneWidget);
  });

  testWidgets('Random Selection should pick an option from the list',
      (WidgetTester tester) async {
    // สร้างหน้า SpinWheelScreen ขึ้นมา
    await tester.pumpWidget(const MaterialApp(
      home: SpinWheelScreen(),
    ));

    // เพิ่มตัวเลือกลงใน options 3 ตัวเลือก
    await tester.enterText(find.byType(TextField), 'Option 1');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // อัปเดต UI

    await tester.enterText(find.byType(TextField), 'Option 2');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // อัปเดต UI

    await tester.enterText(find.byType(TextField), 'Option 3');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // อัปเดต UI

    // ตรวจสอบว่ามีตัวเลือก 3 ตัวเลือกถูกเพิ่มแล้ว
    expect(find.text('Option 1'), findsOneWidget);
    expect(find.text('Option 2'), findsOneWidget);
    expect(find.text('Option 3'), findsOneWidget);

    // กดปุ่มสุ่ม (เพื่อเรียกใช้ _startRandomSelection)
    await tester
        .tap(find.text('To Day is...')); // หรือใช้ find.byType(ElevatedButton)

    // รอให้การสุ่มทำงานเสร็จ
    await tester.pumpAndSettle(); // รอให้แอนิเมชันและการอัปเดตทั้งหมดเสร็จสิ้น

    // ตรวจสอบว่าตัวเลือกที่ถูกสุ่มอยู่ใน options
    final String selectedOption =
        (tester.firstWidget(find.textContaining('Option')) as Text).data!;
    expect(
        ['Option 1', 'Option 2', 'Option 3'].contains(selectedOption), isTrue);
  });

  testWidgets('Clear all options', (WidgetTester tester) async {
    // สร้างหน้า SpinWheelScreen ขึ้นมา
    await tester.pumpWidget(const MaterialApp(
      home: SpinWheelScreen(),
    ));

    // เพิ่มตัวเลือก 2 อัน
    await tester.enterText(find.byType(TextField), 'Option 1');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // ให้ UI อัปเดต

    await tester.enterText(find.byType(TextField), 'Option 2');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // ให้ UI อัปเดต

    // ตรวจสอบว่ามีตัวเลือกทั้ง 2 อันถูกเพิ่มแล้ว
    expect(find.text('Option 1'), findsOneWidget);
    expect(find.text('Option 2'), findsOneWidget);

    // กดปุ่มลบทั้งหมด
    await tester.tap(find.byIcon(Icons.delete_sweep));
    await tester.pump(); // ให้ UI อัปเดต

    // ตรวจสอบว่าตัวเลือกทั้งหมดถูกลบออก
    expect(find.text('Option 1'), findsNothing);
    expect(find.text('Option 2'), findsNothing);
  });
}
