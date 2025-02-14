import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // สำหรับการใช้ Provider
import 'dart:async'; // สำหรับใช้ Timer
import 'dart:math'; // สำหรับการสุ่ม
import 'package:flutter_application_1/screen/LocaleProvidelanguage_provider.dart'; // Import LanguageProvider
import 'package:flutter_application_1/screen/theme_provider.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen>
    with SingleTickerProviderStateMixin {
  String randomQuote = 'To Day is...';
  late AnimationController _controller;
  bool isRandomizing = false;
  Timer? _timer;
  int currentIndex = 0;
  late List<String> quotes; // รายการคำคม

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ฟังก์ชันสุ่มคำคม
  void randomizeQuote() {
    final randomIndex = Random().nextInt(quotes.length);
    setState(() {
      randomQuote = quotes[randomIndex];
    });
  }

  // ฟังก์ชันให้ข้อความวิ่งไปมาแล้วจึงสุ่ม
  void startRandomizing() {
    setState(() {
      isRandomizing = true;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % quotes.length;
        randomQuote = quotes[currentIndex];
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      _timer?.cancel();
      randomizeQuote();
      setState(() {
        isRandomizing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider =
        Provider.of<ThemeProvider>(context); // เข้าถึง ThemeProvider

    // รายการคำคมที่ถูกแปลตามภาษาที่เลือก
    quotes = [
      languageProvider.getTranslation('quote_1') ?? 'Believe in yourself!',
      languageProvider.getTranslation('quote_2') ??
          'You are stronger than you think.',
      languageProvider.getTranslation('quote_3') ??
          'Keep going, you are doing great!',
      languageProvider.getTranslation('quote_4') ?? 'Success is not far away.',
      languageProvider.getTranslation('quote_5') ??
          'Stay positive, work hard, make it happen.',
      languageProvider.getTranslation('quote_6') ??
          'Collaboration will be the key.',
      languageProvider.getTranslation('quote_7') ??
          'Every day is a new beginning.',
      languageProvider.getTranslation('quote_8') ??
          'You are capable of amazing things.',
      languageProvider.getTranslation('quote_9') ??
          'Believe in yourself and all that you are.',
      languageProvider.getTranslation('quote_10') ??
          'Difficult roads often lead to beautiful destinations.',
      languageProvider.getTranslation('quote_11') ??
          'Success is not final, failure is not fatal: it is the courage to continue that counts.',
      languageProvider.getTranslation('quote_12') ??
          'Don’t stop until you’re proud of yourself.',
      languageProvider.getTranslation('quote_13') ?? 'The best is yet to come.',
      languageProvider.getTranslation('quote_14') ??
          'Challenges are what make life interesting.',
      languageProvider.getTranslation('quote_15') ??
          'You have the power to change your story.',
      languageProvider.getTranslation('quote_16') ??
          'Take a deep breath and keep moving forward.',
      languageProvider.getTranslation('quote_17') ??
          'Believe you can, and that’s halfway to success.',
      languageProvider.getTranslation('quote_18') ??
          'It’s never too late to be what you might have been.',
      languageProvider.getTranslation('quote_19') ??
          'Progress is progress, no matter how small.',
      languageProvider.getTranslation('quote_20') ??
          'Mistakes are proof that you’re trying.',
      languageProvider.getTranslation('quote_21') ??
          'You are enough just as you are.',
      languageProvider.getTranslation('quote_22') ??
          'Great things never come from comfort zones.',
      languageProvider.getTranslation('quote_23') ?? 'You are your only limit.',
      languageProvider.getTranslation('quote_24') ??
          'The only way to do great work is to love what you do.',
      languageProvider.getTranslation('quote_25') ??
          'Don’t wait for opportunity, create it.',
      languageProvider.getTranslation('quote_26') ??
          'Keep your head up, and your heart open.',
      languageProvider.getTranslation('quote_27') ??
          'Storms don’t last forever.',
      languageProvider.getTranslation('quote_28') ??
          'Small steps in the right direction could turn out to be the biggest steps of your life.',
      languageProvider.getTranslation('quote_29') ??
          'Dream big, take action to make it happen.',
      languageProvider.getTranslation('quote_30') ??
          'The harder you work for something, the better you’ll feel when you succeed.',
      languageProvider.getTranslation('quote_31') ??
          'Success is not how high you’ve climbed, but how you make a positive impact on the world.',
      languageProvider.getTranslation('quote_32') ??
          'A small positive thought in the morning can change your whole day.',
      languageProvider.getTranslation('quote_33') ??
          'Rise above the storm and you will find the sunshine.',
      languageProvider.getTranslation('quote_34') ??
          'You are more powerful than you know.',
      languageProvider.getTranslation('quote_35') ??
          'Be a warrior, not a worrier.',
      languageProvider.getTranslation('quote_36') ??
          'Your potential is endless.',
      languageProvider.getTranslation('quote_37') ?? 'Focus on the good.',
      languageProvider.getTranslation('quote_38') ??
          'Life may be tough, but so are you.',
      languageProvider.getTranslation('quote_39') ?? 'Good things are coming.',
      languageProvider.getTranslation('quote_40') ??
          'Every day may not be good, but there is something good in every day.',
      languageProvider.getTranslation('quote_41') ?? 'You’ve got this.',
      languageProvider.getTranslation('quote_42') ??
          'Don’t give up, great things take time.',
      languageProvider.getTranslation('quote_43') ?? 'Be brave, take risks.',
      languageProvider.getTranslation('quote_44') ??
          'You are braver than you believe, stronger than you seem, and smarter than you think.',
      languageProvider.getTranslation('quote_45') ??
          'Failure is not the opposite of success; it’s part of success.',
      languageProvider.getTranslation('quote_46') ??
          'Sometimes you win, sometimes you learn.',
      languageProvider.getTranslation('quote_47') ??
          'Your dreams don’t have an expiration date.',
      languageProvider.getTranslation('quote_48') ??
          'Be the energy you want to attract.',
      languageProvider.getTranslation('quote_49') ??
          'The best view comes after the hardest climb.',
      languageProvider.getTranslation('quote_50') ??
          'Start where you are, use what you have, do what you can.',
      languageProvider.getTranslation('quote_51') ??
          'You are capable of more than you know.',
      languageProvider.getTranslation('quote_52') ??
          'Doubt kills more dreams than failure ever will.',
    ];

    return Scaffold(
      backgroundColor: themeProvider.isDarkTheme
          ? const Color.fromARGB(255, 58, 51, 51)
          : Colors.red,
      appBar: AppBar(
        title: const Text('Quotes'),
        backgroundColor: themeProvider.isDarkTheme
            ? const Color.fromARGB(255, 23, 22, 22)
            : Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 80,
                color: themeProvider.isDarkTheme
                    ? Colors.white
                    : const Color.fromARGB(255, 58, 51, 51),
              ),
              const SizedBox(height: 20),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 10 * sin(value * 2 * pi)),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkTheme
                            ? Colors.grey[800]
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        randomQuote,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: themeProvider.isDarkTheme
                              ? Colors.white
                              : const Color.fromARGB(255, 58, 51, 51),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isRandomizing ? null : startRandomizing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.isDarkTheme
                      ? Colors.black
                      : const Color(0xFFF2C488), // เปลี่ยนสีพื้นหลัง
                  foregroundColor: themeProvider.isDarkTheme
                      ? Colors.black
                      : Colors.white, // เปลี่ยนสีตัวอักษร
                ),
                child: Text(
                  'To Day is...',
                  style: TextStyle(
                    color:
                        themeProvider.isDarkTheme ? Colors.white : Colors.black,
                  ), // เปลี่ยนสีตัวอักษรเป็นสีดำ
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
