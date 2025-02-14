import 'package:flutter/material.dart';
import 'dart:math'; // สำหรับการสุ่มสี

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  _ColorScreenState createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;
  String selectedColor = 'To Day is...';
  bool isRandomizing = false;
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple
  ];

  List<String> colorNames = [
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Purple"
  ];

  @override
  void initState() {
    super.initState();

    // สร้าง AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // ระยะเวลาแอนิเมชัน 5 วินาที
      vsync: this,
    );

    // กำหนด Animation ของสี โดยจะค่อยๆ เปลี่ยนจากสีแรกไปยังสีสุ่มได้เรื่อยๆ
    _animation = ColorTween(
      begin: colors[0],
      end: colors[Random().nextInt(colors.length)],
    ).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isRandomizing = false;
          });
        }
      });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ฟังก์ชันสุ่มสี
  void startRandomizing() {
    setState(() {
      isRandomizing = true;
      selectedColor = '';
    });

    // สุ่มสีใหม่สำหรับ Animation
    int fastChanges = 6; // จำนวนการเปลี่ยนสีที่เร็ว
    Duration fastDuration =
        const Duration(milliseconds: 500); // ระยะเวลาของแต่ละสี

    _controller.duration = fastDuration;
    _controller.repeat(period: fastDuration);

    Future.delayed(Duration(milliseconds: fastChanges * 300), () {
      // หลังจากเปลี่ยนสีไวหลายรอบแล้วให้หยุดที่สีสุดท้าย
      _controller.stop();
      int finalIndex = Random().nextInt(colors.length);
      _animation = ColorTween(
        begin: _animation.value,
        end: colors[finalIndex],
      ).animate(_controller);

      _controller.duration = const Duration(seconds: 2);
      _controller.forward().then((_) {
        setState(() {
          selectedColor = colorNames[finalIndex]; // ชื่อสีที่สุ่มได้
          isRandomizing = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color in Day'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: _animation.value ?? Colors.white, // แสดงสีปัจจุบันจาก Animation
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedColor,
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isRandomizing ? null : startRandomizing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  'To Day is...',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
