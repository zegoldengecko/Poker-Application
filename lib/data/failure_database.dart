import 'package:push_fold_main/models/drill_spot.dart';
import 'failure_record.dart';

// Database of failure records keyed by the storage string
class FailureDatabase {
  final Map<String, FailureRecord> failureDB = {};

  //**
  // Records a failure for the given DrillSpot
  // Builds a uniqe key from the spot details then increments failure weight
  //*/
  void recordFailure(DrillSpot spot) {
    final storageString = spot.toStorageKey();

    if (failureDB.containsKey(storageString)) {
      failureDB[storageString] !.weight += 1;
    } else {
      failureDB[storageString] = FailureRecord(weight: 1);
    }
  }

  //**
  // Removes/reduces a failure record for the given Drillspot
  // If the spots' weight is 1 or less, the record is deleted
  //*/
  void removeFailure(DrillSpot spot) {
    final storageString = spot.toStorageKey();

    if (failureDB.containsKey(storageString)) {
      final record = failureDB[storageString]!;

      if (record.weight <= 1) {
        failureDB.remove(storageString);
      } else {
        record.weight -= 1;
      }
    }
  }

  // Get the database
  Map<String, FailureRecord> get db => failureDB;
}

// Creating an instance
final failureDatabase = FailureDatabase();