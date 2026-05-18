// Parses a hand string into two cards for display
List<Map<String, dynamic>> parseHand(String hand) {
  const suitSymbols = {'h': '♥', 'd': '♦', 'c': '♣', 's': '♠'};
  const redSuits = {'h', 'd'};

  // Suited hand e.g. "Ad4d"
  if (hand.length == 4) {
    final r1 = hand[0];
    final s1 = hand[1];
    final r2 = hand[2];
    final s2 = hand[3];
    return [
      {'rank': r1, 'suit': suitSymbols[s1] ?? s1, 'red': redSuits.contains(s1)},
      {'rank': r2, 'suit': suitSymbols[s2] ?? s2, 'red': redSuits.contains(s2)},
    ];
  }

  // Offsuit/pair e.g. "AKo" or "AA"
  final r1 = hand[0];
  final r2 = hand[1];
  return [
    {'rank': r1, 'suit': '♠', 'red': false},
    {'rank': r2, 'suit': (hand.endsWith('o') ? '♥' : '♣'), 'red': hand.endsWith('o')},
  ];
}