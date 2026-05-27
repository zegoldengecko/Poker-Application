// A unique identifier for this spot
class DrillSpot {
  final String position;
  final int stack;
  final String hand;

  DrillSpot({
    required this.position,
    required this.stack,
    required this.hand
  });

  // Returns a unique string key combining position, stack, and hand (e.g. BTN_5_AKo)
  String toStorageKey() => '${position}_${stack}_$hand';

  // Parsing a key back into a drill spot
  factory DrillSpot.fromStorageKey(String key) {
    final parts = key.split('_');
    
    return DrillSpot(
      position: parts[0],
      stack: int.parse(parts[1]),
      hand: parts[2]
    );
  }
}
