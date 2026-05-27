import 'package:flutter/material.dart';
import 'package:push_fold_main/data/stats_database.dart';
import 'package:push_fold_main/services/stats_calculator.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  late StatsCalculator calculator;

  final List<String> positions = ['BTN', 'SB', 'BB', 'CO', 'HJ', 'UTG'];

  @override
  void initState() {
    super.initState();
    calculator = StatsCalculator(statsDatabase.db);
  }

  String _pct(double val) => '${(val * 100).toStringAsFixed(1)}%';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text('Overall', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _row('Total accuracy', _pct(calculator.getTotalAccuracy())),
          _row('Last 100 attempts', _pct(calculator.get100Attempts())),
          _row('Last 1000 attempts', _pct(calculator.get1000Attempts())),
          _row('Current streak', '${calculator.getCurrentStreak()} correct'),
          _row('Days streak', '${calculator.getDaysStreak()} days'),

          const SizedBox(height: 24),
          const Text('By Position', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...positions.map((pos) => _row(pos, _pct(calculator.getAccuracyForPosition(pos)))),

        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}