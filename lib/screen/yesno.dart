import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'LocaleProvidelanguage_provider.dart'; // Import LanguageProvider

class YesNoScreen extends StatefulWidget {
  const YesNoScreen({super.key});

  @override
  _YesNoScreenState createState() => _YesNoScreenState();
}

class _YesNoScreenState extends State<YesNoScreen>
    with SingleTickerProviderStateMixin {
  String result = 'Press the button!';
  IconData iconData = FontAwesomeIcons.questionCircle;
  bool isLoading = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void randomize() async {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);

    setState(() {
      isLoading = true;
      result = languageProvider.getTranslation('randomizing') ??
          'Randomizing...'; // ใช้คำแปล
      iconData = FontAwesomeIcons.spinner;
      _controller.repeat();
    });

    await Future.delayed(const Duration(seconds: 3));

    final List<String> options = ['Yes', 'No'];
    final List<IconData> icons = [
      FontAwesomeIcons.checkCircle,
      FontAwesomeIcons.timesCircle
    ];

    setState(() {
      int randomIndex = Random().nextInt(options.length);
      result = options[randomIndex];
      iconData = icons[randomIndex];
      isLoading = false;
      _controller.stop();
      _controller.reset();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${languageProvider.getTranslation('you_got') ?? 'You got:'} $result', // ใช้คำแปล
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ใช้ LanguageProvider
    final languageProvider = Provider.of<LanguageProvider>(context);

    final ThemeData theme = Theme.of(context);
    final appBarColor =
        theme.brightness == Brightness.dark ? Colors.black : Colors.white;
    final backgroundColor =
        theme.brightness == Brightness.dark ? Colors.grey[800] : Colors.red;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Yes / No',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
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
          color: backgroundColor,
        ),
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RotationTransition(
                  turns: _controller,
                  child: FaIcon(
                    iconData,
                    color: Colors.white,
                    size: 150,
                  ),
                ),
                const SizedBox(height: 20),
                FadeIn(
                  child: Text(
                    result, // ใช้ค่า result ที่จะถูกอัปเดต
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge!.color,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: isLoading ? null : randomize,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        )
                      : const Text(
                          'To Day is...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
