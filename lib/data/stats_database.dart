import 'stats_record.dart';

// Database of all answers keyed by spot storage string
class StatsDatabase {
  final Map<String, List<StatsRecord>> statsDB = {};

  //**
  // Records a result in the stats database after an attempt is made on a specific question
  //*/
  void recordResult(StatsRecord record) {
    statsDB.putIfAbsent(record.spot, () => []).add(record);
  }

  // Get the database
  Map<String, List<StatsRecord>> get db => statsDB;
}

// Creating an instance
final statsDatabase = StatsDatabase();