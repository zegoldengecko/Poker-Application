import 'package:flutter/material.dart';
import 'package:push_fold_main/screens/drill_screen.dart';
import 'package:push_fold_main/screens/stat_screen.dart';
import 'package:push_fold_main/services/drill_settings.dart';

// Main title screen for the application
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32),
      body: Column(
        children: [
          // App title banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.red,
            child: const SafeArea(
              bottom: false,
              child: Center(
                child: Text(
                  "placeholder poker app name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/title_royal_flush.png',
                    width: 180,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 20),
                  const _AnteSelector(),
                  const SizedBox(height: 20),

                  // Navigating to the Drill Screen
                  _MenuButton(
                    title: "Practice",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DrillScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),
                  const _MenuButton(title: "Learn"),
                  const SizedBox(height: 16),

                  // Navigating to the Stats Screen
                  _MenuButton(
                    title: "Stats",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StatScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Defining the menu buttons
class _MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const _MenuButton({
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}

// Lets the user pick the ante level used for future drill spots
class _AnteSelector extends StatelessWidget {
  const _AnteSelector();

  static const _options = [
    {'value': '0', 'label': '0%'},
    {'value': '10', 'label': '10%'},
    {'value': '12.5', 'label': '12.5%'},
    {'value': 'bb', 'label': 'BB'},
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: DrillSettings.anteLevel,
      builder: (context, selected, _) {
        return Column(
          children: [
            const Text(
              'Ante',
              style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: _options.map((opt) {
                final isSelected = opt['value'] == selected;
                return GestureDetector(
                  onTap: () => DrillSettings.anteLevel.value = opt['value']!,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white54, width: 1),
                    ),
                    child: Text(
                      opt['label']!,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF2E7D32) : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}