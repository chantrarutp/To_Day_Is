import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // สถานะปัจจุบันของธีม (ค่าเริ่มต้นเป็นธีมสว่าง)
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  // ฟังก์ชันสลับระหว่างธีมสว่างและธีมมืด
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  // กำหนดธีมสว่างและธีมมืด
  ThemeData get currentTheme {
    return _isDarkTheme
        ? ThemeData.dark().copyWith(
            primaryColor: Colors.grey[900],
            scaffoldBackgroundColor: const Color.fromARGB(255, 58, 51, 51),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.white), // เปลี่ยนจาก bodyText1 เป็น bodyLarge
            ),
          )
        : ThemeData.light().copyWith(
            primaryColor: Colors.red,
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.black), // เปลี่ยนจาก bodyText1 เป็น bodyLarge
            ),
          );
  }
}
