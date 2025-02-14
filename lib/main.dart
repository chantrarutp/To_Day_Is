import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/LocaleProvidelanguage_provider.dart'; // import ไฟล์ language_provider ที่สร้างไว้
import 'package:flutter_application_1/screen/theme_provider.dart'; // import ไฟล์ ThemeProvider ที่สร้างไว้
import 'screen/login_screen.dart'; // import ไฟล์ของหน้าล็อกอิน

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => LanguageProvider()), // รองรับการเปลี่ยนภาษา
        ChangeNotifierProvider(
            create: (context) => ThemeProvider()), // รองรับการเปลี่ยนธีม
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider =
        Provider.of<ThemeProvider>(context); // เข้าถึง ThemeProvider

    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeProvider.currentTheme, // ตั้งค่าธีมปัจจุบัน
      home: const LoginScren(), // กำหนดหน้าหลักเป็นหน้าล็อกอิน
    );
  }
}
