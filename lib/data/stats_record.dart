import 'package:push_fold_main/models/drill_spot.dart';

// Represents a single record of a question and the attempt
class StatsRecord {
  int timestamp;
  String spot;
  int result;

  StatsRecord({
    required this.timestamp,
    required DrillSpot drillspot,
    required this.result
  })  : spot = drillspot.toStorageKey();
}