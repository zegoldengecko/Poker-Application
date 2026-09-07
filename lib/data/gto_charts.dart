// -----------------------------------------------------------------------------
// Parent Function for GTO charts
// -----------------------------------------------------------------------------

import 'package:push_fold_main/models/drill_spot.dart';
import 'package:push_fold_main/data/gto_charts/no_ante_chart.dart';
import 'package:push_fold_main/data/gto_charts/ten_percent_ante_chart.dart';
import 'package:push_fold_main/data/gto_charts/twelve_five_ante_chart.dart';
import 'package:push_fold_main/data/gto_charts/bb_ante_chart.dart';

// ranking cards from lowest to highest and converting to a number
const String _ranks = '23456789TJQKA';
int _rankIndex(String r) => _ranks.indexOf(r);

/// Expands a shorthand token like 'A2s+', '22+', 'AKo' into explicit hands.
List<String> _expandToken(String token) {
  final List<String> result = [];
  final bool isPlus = token.endsWith('+');
  final String t = isPlus ? token.substring(0, token.length - 1) : token;

  // CASE 1: Pocket pairs
  if (t.length == 2 && t[0] == t[1]) {
    final int base = _rankIndex(t[0]);
    if (isPlus) {
      for (int i = base; i < _ranks.length; i++) {
        result.add('${_ranks[i]}${_ranks[i]}');
      }
    } else {
      result.add('${t[0]}${t[1]}');
    }
    return result;
  }

  // CASE 2: Suited/offsuit hands
  if (t.length == 3) {
    final String hi = t[0];
    final String lo = t[1];
    final String suit = t[2]; // 's' or 'o'
    final int hiIdx = _rankIndex(hi);
    final int loIdx = _rankIndex(lo);

    if (isPlus) {
      // Iterate kicker from loIdx up to hiIdx - 1
      for (int i = loIdx; i < hiIdx; i++) {
        result.add('$hi${_ranks[i]}$suit');
      }
    } else {
      result.add('$hi$lo$suit');
    }
    return result;
  }

  // CASE 3: No suit specified, counts as both suited and offsuit
  if (t.length == 2) {
    final String hi = t[0];
    final String lo = t[1];
    final int hiIdx = _rankIndex(hi);
    final int loIdx = _rankIndex(lo);
    if (isPlus) {
      for (int i = loIdx; i < hiIdx; i++) {
        result.add('$hi${_ranks[i]}s');
        result.add('$hi${_ranks[i]}o');
      }
    } else {
      result.add('$hi${lo}s');
      result.add('$hi${lo}o');
    }
    return result;
  }

  return result;
}

/// Parses a full range string into a deduplicated list of hands.
List<String> parseRange(String range) {
  if (range.trim().isEmpty) return [];
  final Set<String> hands = {};
  for (final token in range.trim().split(RegExp(r'\s+'))) {
    hands.addAll(_expandToken(token));
  }
  return hands.toList();
}

// Ante level -> position -> stack -> range string. Ante keys: '0', '10', '12.5', 'bb'
const Map<String, Map<String, Map<int, String>>> gtoCharts = {
  '0': noAnteChart,
  '10': tenPercentAnteChart,
  '12.5': twelveFiveAnteChart,
  'bb': bbAnteChart,
};


/// Returns true if the given spot is a shove according to GTO charts
bool shouldShove(DrillSpot spot) {
  final posMap = noAnteChart[spot.position];
  if (posMap == null) return false;
  final range = posMap[spot.stack];
  if (range == null) return false;
  return parseRange(range).contains(spot.hand);
}