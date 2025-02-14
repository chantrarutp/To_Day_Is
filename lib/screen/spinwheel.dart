import 'package:flutter/material.dart';
import 'dart:math';

class SpinWheelScreen extends StatefulWidget {
  const SpinWheelScreen({super.key});

  @override
  _SpinWheelScreenState createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen>
    with SingleTickerProviderStateMixin {
  Set<String> options = {}; // Use Set to keep unique options
  String selectedOption = '';
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  final Random _random = Random();

  // List of colors for bubbles
  final List<Color> bubbleColors = [
    const Color.fromARGB(255, 225, 235, 253),
    const Color.fromARGB(255, 255, 221, 221),
    const Color.fromARGB(255, 230, 255, 243),
    const Color.fromARGB(255, 255, 245, 232),
    const Color.fromARGB(255, 251, 227, 255),
    const Color.fromARGB(255, 220, 255, 247),
    const Color.fromARGB(255, 255, 255, 215),
  ];

  final Color resultBubbleColor =
      Colors.amberAccent; // Color for the result bubble

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 4000), // Adjust total animation duration
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _addOption() {
    if (_controller.text.isNotEmpty) {
      // Check if the option already exists
      if (options.contains(_controller.text)) {
        // Show Snackbar if the option is duplicate
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a unique option.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          options.add(_controller.text); // Add to Set for uniqueness
          _controller.clear();
        });
      }
    }
  }

  void _removeOption(String option) {
    setState(() {
      options.remove(option);
    });
  }

  // Function to clear all options
  void _clearAllOptions() {
    setState(() {
      options.clear();
      selectedOption = ''; // Clear selected option as well
    });
  }

  void _startRandomSelection() async {
    if (options.isEmpty) return;

    _animationController.repeat(reverse: true);

    // Initialize delay and max iterations
    int maxIterations = 15;
    int delay = 100; // Initial delay in milliseconds

    for (int i = 0; i < maxIterations; i++) {
      setState(() {
        selectedOption = options.elementAt(_random.nextInt(options.length));
      });
      await Future.delayed(Duration(milliseconds: delay));

      // Gradually increase the delay to slow down towards the end
      if (i < maxIterations - 5) {
        delay = max(50, delay - 15); // Speed up initially
      } else {
        delay += 50; // Slow down towards the end
      }
    }

    _animationController.stop();
  }

  // Function to get a random color for bubbles
  Color _getBubbleColor(String option) {
    // If the option is the selected option, return the result color
    if (option == selectedOption) {
      return resultBubbleColor;
    }
    // Otherwise, return a random color from the bubbleColors list
    return bubbleColors[_random.nextInt(bubbleColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    // ใช้ Theme.of(context) เพื่อตรวจสอบสถานะของธีม
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mystery box'),
      ),
      body: Container(
        color: theme.scaffoldBackgroundColor, // ใช้สีพื้นหลังตามธีม
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for adding options
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter an option',
                fillColor: isDarkTheme ? Colors.grey[700] : Colors.white,
                // เปลี่ยนสีของช่องกรอกข้อมูลตามธีม
                filled: true,
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
              style: TextStyle(
                  color: theme.textTheme.bodyLarge!.color), // สีข้อความตามธีม
            ),
            const SizedBox(height: 20),
            // Row for Add and Clear buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addOption,
                  tooltip: 'Add Option',
                  color: theme.iconTheme.color, // ปรับสีไอคอนตามธีม
                ),
                IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  onPressed: _clearAllOptions,
                  tooltip: 'Clear All Options',
                  color: theme.iconTheme.color, // ปรับสีไอคอนตามธีม
                ),
              ],
            ),
            const SizedBox(height: 20),
            // List of options displayed as bubbles
            Expanded(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: options.map((option) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getBubbleColor(option), // ใช้สี bubble
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // Keep the size just for text
                      children: [
                        Text(
                          option,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            width: 8), // Space between text and delete icon
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeOption(option),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            // Animated selected option display
            AnimatedBuilder(
              animation: _colorAnimation,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.cardColor, // ใช้สีตามธีม
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    selectedOption.isEmpty ? '?' : selectedOption,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: _colorAnimation.value,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            // Randomize button
            ElevatedButton(
              onPressed: _startRandomSelection,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                backgroundColor: theme.primaryColor, // ปรับสีปุ่มตามธีม
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30), // Make button rounder
                ),
              ),
              child: const Text('To Day is...', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
