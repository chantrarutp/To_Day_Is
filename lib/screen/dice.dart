import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/LocaleProvidelanguage_provider.dart';
import 'package:flutter_application_1/screen/theme_provider.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  DiceScreenState createState() => DiceScreenState();
}

class DiceScreenState extends State<DiceScreen> {
  int numberOfDice = 1;
  List<int> diceValues = [];
  int sum = 0;
  bool isRolling = false;
  Timer? sumTimer;
  List<int> randomDiceFaces = [];

  void rollDice() async {
    setState(() {
      isRolling = true;
      diceValues = List.filled(numberOfDice, 0);
      randomDiceFaces = List.filled(numberOfDice, 1);
      sum = 0;
    });

    sumTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        randomDiceFaces =
            List.generate(numberOfDice, (index) => Random().nextInt(6) + 1);
      });
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      diceValues =
          List.generate(numberOfDice, (index) => Random().nextInt(6) + 1);
      sum = diceValues.reduce((a, b) => a + b);
      isRolling = false;
    });

    sumTimer?.cancel();
  }

  @override
  void dispose() {
    sumTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    String title = languageProvider.getTranslation('dice_title') ?? 'Dice';
    String numberOfDiceText =
        languageProvider.getTranslation('number_of_dice') ?? 'Number of dice:';
    String diceResultsText =
        languageProvider.getTranslation('dice_results') ?? 'Dice Results:';
    String sumText = languageProvider.getTranslation('sum') ?? 'Sum:';

    Color textColor = themeProvider.isDarkTheme
        ? Colors.white
        : Colors.black; // กำหนดสีของข้อความ
    Color diceNumberColor =
        Colors.black; // สีสำหรับตัวเลขในการเลือกจำนวนลูกเต๋า

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: themeProvider.isDarkTheme
            ? Colors.black
            : const Color.fromARGB(255, 249, 232, 231),
      ),
      body: Container(
        color: themeProvider.isDarkTheme ? Colors.grey[850] : Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numberOfDiceText,
                style: TextStyle(color: textColor), // ใช้สีที่กำหนด
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        numberOfDice = index + 1;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                        color: numberOfDice == index + 1
                            ? Colors.amberAccent
                            : Colors.white,
                      ),
                      child: Text(
                        '${index + 1}',
                        style:
                            TextStyle(color: diceNumberColor), // สีสำหรับตัวเลข
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              Text(
                diceResultsText,
                style:
                    TextStyle(fontSize: 28, color: textColor), // ใช้สีที่กำหนด
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: isRolling
                    ? List.generate(numberOfDice, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'dice_${randomDiceFaces[index]}.png',
                                height: 100,
                                width: 100,
                              ),
                              const SizedBox(height: 4),
                              Text('?',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: textColor)), // ใช้สีที่กำหนด
                            ],
                          ),
                        );
                      })
                    : diceValues.map((value) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'dice_$value.png',
                                height: 100,
                                width: 100,
                              ),
                              const SizedBox(height: 4),
                              Text('$value',
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: textColor)), // ใช้สีที่กำหนด
                            ],
                          ),
                        );
                      }).toList(),
              ),
              const SizedBox(height: 40),
              isRolling
                  ? Image.asset(
                      'dice_0.png',
                      height: 100,
                      width: 100,
                    )
                  : Text(
                      '$sumText $sum',
                      style: TextStyle(
                          fontSize: 30, color: textColor), // ใช้สีที่กำหนด
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: rollDice,
                child: const Text('To Day is...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
