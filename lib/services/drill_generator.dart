import 'dart:math';
import 'package:push_fold_main/models/drill_spot.dart';
import 'package:push_fold_main/data/failure_database.dart';

final _positions = ['SB', 'UTG', 'UTG+1', 'UTG+2', 'UTG+3', 'LJ', 'HJ', 'CO', 'BTN'];
final _stacks = List.generate(15, (i) => i + 1);


//** 
// Generates a random Drillspot, with a 1 in 3 chance of pulling from previously failed hands
//*/ 
DrillSpot generateRandomSpot() {
  final rand = Random();

  // 1 in 3 chance of pulling from list of commonly failing hands
  if ((rand.nextInt(3) + 1) > 2) {
    return useChallengingHand(rand);
  }

  // Otherwise generate new hand
  final position = _positions[rand.nextInt(_positions.length)];
  final stack = _stacks[rand.nextInt(_stacks.length)];
  final hand = _randomHand(rand);

  return DrillSpot(position: position, stack: stack, hand: hand);
}

//**
// Generates a random poker hand string (e.g. AKs, 72o, TT)
// */
String _randomHand(Random rand) {
  const ranks = '23456789TJQKA';

  final r1 = ranks[rand.nextInt(ranks.length)];
  final r2 = ranks[rand.nextInt(ranks.length)];
  
  // Pocket pair
  if (r1 == r2) {
    return '$r1$r2';
  }

  // Checking suited or not
  final suited = rand.nextBool() ? 's' : 'o';

  // Makes it so the higher rank is always first
  final hi = _rankValue(r1) > _rankValue(r2) ? r1 : r2;
  final lo = hi == r1 ? r2 : r1;

  return '$hi$lo$suited';
}

// Returns the rank index of a card
int _rankValue(String r) => '23456789TJQKA'.indexOf(r);

//**
// Picks a DrillSpot from the FailureDatabase, weighted by failures
// */
DrillSpot useChallengingHand(Random rand) {
  if (failureDatabase.db.isEmpty) {
    return generateRandomSpot();
  }

  final List<String> weightedKeys = [];

  // Adding to weighted keys depending on weight
  for (final entry in failureDatabase.db.entries) {
    for (int i = 0; i < entry.value.weight; i++) {
      weightedKeys.add(entry.key);
    }
  }

  if (weightedKeys.isEmpty) {
    return generateRandomSpot();
  }

  // Picking a random key
  final selectedKey = weightedKeys[rand.nextInt(weightedKeys.length)];
  return DrillSpot.fromStorageKey(selectedKey);
}
