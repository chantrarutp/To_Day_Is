import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LocaleProvidelanguage_provider.dart'; // นำเข้า LanguageProvider
import 'theme_provider.dart'; // นำเข้า ThemeProvider

class SettingMenu extends StatefulWidget {
  @override
  _SettingMenuState createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  String _selectedTheme = 'red'; // Default theme

  @override
  Widget build(BuildContext context) {
    var languageProvider =
        Provider.of<LanguageProvider>(context); // เข้าถึง LanguageProvider
    var themeProvider =
        Provider.of<ThemeProvider>(context); // เข้าถึง ThemeProvider

    // กำหนดสีของตัวอักษรตามโหมดธีม
    Color textColor = themeProvider.isDarkTheme ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme
            ? Colors.grey[900] // สีในธีมมืด
            : themeProvider.currentTheme.primaryColor, // สีในธีมปกติ
        title: Text(
          languageProvider.getTranslation('title') ?? 'Settings',
          style: TextStyle(color: textColor), // เปลี่ยนสีตัวอักษรใน AppBar
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor), // เปลี่ยนสีไอคอน
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            // ปุ่มสวิตช์สำหรับเปลี่ยนโหมดกลางคืน (Dark Mode)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  languageProvider.getTranslation('dark mode') ?? 'Dark mode',
                  style: TextStyle(
                      fontSize: 18, color: textColor), // เปลี่ยนสีตัวอักษร
                ),
                Switch(
                  value: themeProvider.isDarkTheme,
                  onChanged: (value) {
                    themeProvider.toggleTheme(); // สลับธีม
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            // ตัวเลือกสำหรับการเลือกธีมสี
            SizedBox(height: 20),
            Text(
              languageProvider.getTranslation('language') ?? 'Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor, // เปลี่ยนสีตัวอักษร
              ),
            ),
            SizedBox(height: 10),

            // ตัวเลือกสำหรับการเปลี่ยนภาษา
            Row(
              children: [
                _buildLanguageOption(
                    'TH', 'th', languageProvider, Colors.black),
                _buildLanguageOption(
                    'EN', 'en', languageProvider, Colors.black),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้างปุ่มเลือกธีมสี
  Widget _buildColorOption(String theme, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTheme = theme; // Update the selected theme
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _selectedTheme == theme ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสำหรับสร้างปุ่มเลือกภาษา พร้อมปรับสีตามธีม
  Widget _buildLanguageOption(String label, String language,
      LanguageProvider provider, Color textColor) {
    return GestureDetector(
      onTap: () {
        provider.switchLanguage(
            language); // Update the selected language using provider
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: provider.language == language ? Colors.red : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor, // เปลี่ยนสีตัวอักษรตามธีม
          ),
        ),
      ),
    );
  }
}
