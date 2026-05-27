import '../data/stats_record.dart';

// Calculator to get stats depending on what's required
class StatsCalculator {
  final Map<String, List<StatsRecord>> statsDB;

  StatsCalculator(this.statsDB);

  // Private helper to take any list of record and return accuracy
  double _calculateAccuracy(List<StatsRecord> attempts) {
    if (attempts.isEmpty) return 0;
    final correct = attempts.where((r) => r.result == 1).length;
    return correct / attempts.length;
  }

  // Flattens the entire db into a single list
  List<StatsRecord> get _allAttempts =>
    statsDB.values.expand((list) => list).toList();

  // Accuracy over total lifetime
  double getTotalAccuracy() {
    return _calculateAccuracy(_allAttempts);
  }

  // Accuracy over the last 100 attempts
  double get100Attempts() {
    final all = _allAttempts..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return _calculateAccuracy(all.take(100).toList());
  }

  // Accuracy for the last 1000 attempts
  double get1000Attempts() {
    final all = _allAttempts..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return _calculateAccuracy(all.take(1000).toList());
  }

  // All time accuracy for a specific spot
  double getAccuracyForSpot(String spot) {
    final attempts = statsDB[spot] ?? [];
    return _calculateAccuracy(attempts);
  }

  // Accuracy per position at the table
  double getAccuracyForPosition(String position) {
    final attempts = statsDB.entries
        .where((e) => e.key.startsWith('${position}_'))
        .expand((e) => e.value)
        .toList();
    return _calculateAccuracy(attempts);
  }

  // Current streak of correct answers
  int getCurrentStreak() {
    final all = _allAttempts..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    int streak = 0;
    for (final record in all) {
      if (record.result == 1) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  // Number of days with attempts
  int getDaysStreak() {
     final all = _allAttempts..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    if (all.isEmpty) return 0;

    final days = all
        .map((r) => DateTime.fromMillisecondsSinceEpoch(r.timestamp))
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    int streak = 1;
    for (int i = 0; i < days.length - 1; i++) {
      final diff = days[i].difference(days[i + 1]).inDays;
      if (diff == 1) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }
}