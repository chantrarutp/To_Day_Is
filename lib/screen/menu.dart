import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/LocaleProvidelanguage_provider.dart';
import 'settingmenu.dart';
import 'yesno.dart';
import 'dice.dart';
import 'num.dart';
import 'spinwheel.dart'; // อิมพอร์ต MysteryBox
import 'letter.dart';
import 'quote.dart';
import 'color.dart';
import 'package:flutter_application_1/screen/theme_provider.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Map<String, dynamic>> menuItems = [
    {'key': 'yes_no', 'imagePath': 'yesno.png', 'isFavorite': false},
    {'key': 'dice', 'imagePath': 'dice.png', 'isFavorite': false},
    {'key': 'number', 'imagePath': 'num.png', 'isFavorite': false},
    {'key': 'Mysterybox', 'imagePath': 'mysterybox.png', 'isFavorite': false},
    {'key': 'letter', 'imagePath': 'letter.png', 'isFavorite': false},
    {'key': 'quote', 'imagePath': 'Qoute.png', 'isFavorite': false},
    {'key': 'color', 'imagePath': 'color.png', 'isFavorite': false},
  ];

  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    List<Map<String, dynamic>> favoriteItems =
        menuItems.where((item) => item['isFavorite']).toList();
    List<Map<String, dynamic>> otherItems =
        menuItems.where((item) => !item['isFavorite']).toList();

    List<Map<String, dynamic>> displayedFavoriteItems =
        showMore ? favoriteItems : favoriteItems.take(3).toList();

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.currentTheme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: themeProvider.currentTheme == ThemeData.light()
                ? Colors.red // Set the AppBar to red for the default theme
                : themeProvider.currentTheme
                    .primaryColor, // Use the theme's color for other themes
            elevation: 0,
            title: ClipOval(
              child: Image.asset(
                'logo.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SettingMenu()), // Navigate to setting menu
                  );
                },
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                if (favoriteItems.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 100.0,
                        bottom: 8.0,
                        left: 16.0), // เพิ่มระยะห่างด้านซ้าย
                    child: Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red), // ไอคอนหัวใจ
                        SizedBox(
                            width: 8), // ระยะห่างระหว่างไอคอนหัวใจกับข้อความ
                        Text(
                          languageProvider.getTranslation('favorites') ??
                              'Favorites',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (favoriteItems.isNotEmpty)
                  Container(
                    height: 150,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      children: displayedFavoriteItems.map((item) {
                        return _buildMenuItem(item, languageProvider);
                      }).toList(),
                    ),
                  ),
                if (favoriteItems.length > 3)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        showMore = !showMore;
                      });
                    },
                    child: Text(
                      showMore
                          ? languageProvider.getTranslation('show_less') ??
                              "Show Less"
                          : languageProvider.getTranslation('show_more') ??
                              "Show More",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                Divider(
                  thickness: 2,
                  color: Colors.redAccent,
                  indent: 15,
                  endIndent: 15,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: otherItems.map((item) {
                      return _buildMenuItem(item, languageProvider);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(
      Map<String, dynamic> item, LanguageProvider languageProvider) {
    return GestureDetector(
      onTap: () {
        switch (item['key']) {
          case 'yes_no':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => YesNoScreen()),
            );
            break;
          case 'dice':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiceScreen()),
            );
            break;
          case 'number':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NumberScreen()),
            );
            break;
          case 'Mysterybox':
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SpinWheelScreen()), // เปลี่ยนไปใช้ MysteryBoxScreen
            );
            break;
          case 'letter':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LetterScreen()),
            );
            break;
          case 'quote':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuoteScreen()),
            );
            break;
          case 'color':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ColorScreen()),
            );
            break;
          default:
            print('Unknown menu item clicked');
        }
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          children: [
            Image.asset(
              item['imagePath'],
              height: 80,
              width: 80,
            ),
            SizedBox(height: 10),
            Text(languageProvider.getTranslation(item['key']) ?? item['key'],
                style: TextStyle(color: Colors.black)),
            IconButton(
              icon: Icon(
                item['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                color: item['isFavorite'] ? Colors.red : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  item['isFavorite'] = !item['isFavorite'];
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
