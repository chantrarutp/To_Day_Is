import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/LocaleProvidelanguage_provider.dart';
import 'package:flutter_application_1/screen/theme_provider.dart';

class LetterScreen extends StatefulWidget {
  const LetterScreen({super.key});

  @override
  _LetterRandomizerScreenState createState() => _LetterRandomizerScreenState();
}

class _LetterRandomizerScreenState extends State<LetterScreen>
    with SingleTickerProviderStateMixin {
  String randomLetter = '?';
  late AnimationController _controller;
  bool isRandomizing = false;
  Timer? _timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isRandomizing = false;
          randomizeLetter();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void randomizeLetter() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final randomIndex = Random().nextInt(letters.length);
    setState(() {
      randomLetter = letters[randomIndex];
    });
  }

  void startRandomizing() {
    setState(() {
      isRandomizing = true;
    });

    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % letters.length;
        randomLetter = letters[currentIndex];
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      _timer?.cancel();
      randomizeLetter();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    Color textColor = themeProvider.isDarkTheme ? Colors.white : Colors.black;
    Color iconColor = themeProvider.isDarkTheme ? Colors.white : Colors.black;
    Color backgroundColor = themeProvider.isDarkTheme
        ? const Color.fromARGB(221, 32, 29, 29)
        : const Color.fromARGB(255, 244, 67, 54);
    Color buttonColor =
        themeProvider.isDarkTheme ? Colors.black : Colors.amberAccent;

    return Scaffold(
      appBar: AppBar(
        title: Text(languageProvider.getTranslation('letter_randomizer') ??
            'Letter Randomizer'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.filter_none, size: 80, color: iconColor),
              const SizedBox(height: 20),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, 10 * sin(value * 2 * pi)),
                    child: Text(
                      randomLetter,
                      style: TextStyle(
                        fontSize: 100,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isRandomizing ? null : startRandomizing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                ),
                child: Text(
                    languageProvider.getTranslation('randomize_letter') ??
                        'Randomize Letter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
