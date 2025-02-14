import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:provider/provider.dart';
import 'LocaleProvidelanguage_provider.dart'; // Import your LanguageProvider

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  String result = '?';
  bool isLoading = false;
  late Timer timer;
  int randomValue = 0;

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    if (timer.isActive) timer.cancel();
    super.dispose();
  }

  void randomizeNumber() {
    setState(() {
      isLoading = true;
      result = '?';
      randomValue = 0;
    });

    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      setState(() {
        int from = int.tryParse(fromController.text) ?? 0;
        int to = int.tryParse(toController.text) ?? 0;

        if (from < to) {
          randomValue = Random().nextInt(to - from + 1) + from;
        }
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      timer.cancel();
      setState(() {
        int from = int.tryParse(fromController.text) ?? 0;
        int to = int.tryParse(toController.text) ?? 0;

        if (from >= to) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                Provider.of<LanguageProvider>(context, listen: false)
                        .getTranslation('please_ensure_from_less_than_to') ??
                    'Please ensure "From" is less than "To"', // Default message
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          isLoading = false;
          return;
        }

        result = randomValue.toString();
        isLoading = false;
      });

      // แจ้งเตือนเมื่อการสุ่มเสร็จสิ้น
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${Provider.of<LanguageProvider>(context, listen: false).getTranslation('you_got')} $result', // Use translation for "You got:"
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final languageProvider =
        Provider.of<LanguageProvider>(context); // Get the language provider

    // กำหนดสีของแถบหัวข้อและพื้นหลังตามธีมปัจจุบัน
    final appBarColor = theme.brightness == Brightness.dark
        ? Colors.black
        : Colors.white; // สีแถบหัวข้อ
    final backgroundColor = theme.brightness == Brightness.dark
        ? Colors.grey[800]
        : Colors.red; // สีพื้นหลัง

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor, // สีแถบหัวข้อ
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Number Randomizer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black, // สีข้อความตามธีม
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: backgroundColor, // สีพื้นหลัง
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: fromController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: languageProvider
                              .getTranslation('from_label'), // Use translation
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: theme.brightness == Brightness.dark
                              ? Colors.grey[700]
                              : Colors.white, // สีพื้นหลังของช่องกรอกตามธีม
                          labelStyle: TextStyle(
                            color: theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.orangeAccent, // สีข้อความตามธีม
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: TextField(
                        controller: toController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: languageProvider
                              .getTranslation('to_label'), // Use translation
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: theme.brightness == Brightness.dark
                              ? Colors.grey[700]
                              : Colors.white, // สีพื้นหลังของช่องกรอกตามธีม
                          labelStyle: TextStyle(
                            color: theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.orangeAccent, // สีข้อความตามธีม
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isLoading
                    ? Text(
                        randomValue.toString(),
                        key: ValueKey<int>(randomValue),
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge!.color,
                          shadows: const [
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(3, 3),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      )
                    : Text(
                        result,
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge!.color,
                          shadows: const [
                            Shadow(
                              color: Colors.black54,
                              offset: Offset(3, 3),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: isLoading ? null : randomizeNumber,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text(
                  isLoading
                      ? languageProvider.getTranslation('randomizing') ??
                          'Randomizing...' // Default fallback message
                      : 'To Day is...', // คงข้อความ "To Day is..." ไว้
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.textTheme.bodyLarge!.color!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
