// -----------------------------------------------------------------------------
// GTO Push/Fold Charts for 12.5% ante
// -----------------------------------------------------------------------------
//
// Range string notation:
//   22+      all pairs from 22 up to AA
//   AKs      exact suited hand
//   AKo      exact offsuit hand
//   A2s+     A2s up to AKs
//   A2o+     A2o up to AKo


// -----------------------------------------------------------------------------
// Chart Data
// position -> stack depth (BB) -> range string (shove = listed, else fold)
// -----------------------------------------------------------------------------

const Map<String, Map<int, String>> twelveFiveAnteChart = {

  // ── SMALL BLIND ──────────────────────────────────────────────────────────
   'SB': {
    1:  '22+ A2s+ A2o+ K2s+ K2o+ Q2s+ Q2o+ J2s+ J2o+ T2s+ T2o+ 92s+ 92o+ 82s+ 84o+ 72s+ 74o+ 62s+ 64o+ 52s+ 54o 42s+',
    2:  '22+ A2s+ A2o+ K2s+ K2o+ Q2s+ Q2o+ J2s+ J2o+ T2s+ T2o+ 92s+ 92o+ 82s+ 82o+ 72s+ 72o+ 62s+ 62o+ 52s+ 52o+ 42s+ 42o+ 32s',
    3:  '22+ 82s+ 82o+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 72s+ 73o+ 62s+ 63o+ 52s+ 53o+ 42s+ 32s',
    4:  '22+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 82s+ 84o+ 73s+ 74o+ 63s+ 65o 53s+ 43s',
    5:  '22+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 92s+ 94o+ 82s+ 85o+ 73s+ 75o+ 63s+ 65o 53s+ 43s',
    6:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T3o+ 92s+ 95o+ 83s+ 85o+ 73s+ 75o+ 63s+ 65o 53s+ 43s',
    7:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T4o+ 92s+ 96o+ 84s+ 86o+ 73s+ 75o+ 63s+ 65o 52s+ 43s',
    8:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T6o+ 92s+ 96o+ 84s+ 86o+ 73s+ 76o 63s+ 65o 52s+ 43s',
    9:  '22+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ J2s+ J4o+ T2s+ T6o+ 93s+ 96o+ 84s+ 86o+ 73s+ 76o 63s+ 65o 52s+ 43s',
    10: '22+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ J2s+ J5o+ T2s+ T6o+ 93s+ 96o+ 84s+ 86o+ 74s+ 76o 63s+ 65o 53s+ 43s',
    11: '22+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ J2s+ J6o+ T2s+ T7o+ 93s+ 96o+ 84s+ 86o+ 74s+ 76o 63s+ 65o 53s+ 43s',
    12: '22+ K2s+ K2o+ A2s+ A2o+ Q2s+ Q3o+ J2s+ J7o+ T3s+ T7o+ 94s+ 97o+ 84s+ 86o+ 74s+ 76o 63s+ 65o 53s+ 43s',
    13: '22+ K2s+ K2o+ A2s+ A2o+ Q2s+ Q4o+ J2s+ J7o+ T3s+ T7o+ 95s+ 97o+ 84s+ 86o+ 74s+ 76o 63s+ 53s+ 43s',
    14: '22+ K2s+ K2o+ A2s+ A2o+ Q2s+ Q4o+ J2s+ J7o+ T3s+ T7o+ 95s+ 97o+ 84s+ 86o+ 74s+ 76o 63s+ 53s+ 43s',
    15: '22+ K2s+ K2o+ A2s+ A2o+ Q2s+ Q5o+ J2s+ J8o+ T4s+ T7o+ 95s+ 97o+ 84s+ 87o 74s+ 76o 63s+ 53s+ 43s',
  },

  'BTN': {
    1:  '22+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 92s+ 94o+ 82s+ 84o+ 72s+ 74o+ 62s+ 64o+ 52s+ 54o 42s+',
    2:  '22+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ J2s+ J5o+ T2s+ T6o+ 95s+ 96o+ 85s+ 86o+ 75s+ 76o 64s+ 54s',
    3:  '22+ A2s+ A2o+ K2s+ K2o+ Q2s+ Q4o+ J2s+ J7o+ T4s+ T7o+ 95s+ 97o+ 85s+ 87o 75s+ 65s',
    4:  '22+ A2s+ A2o+ K2s+ K2o+ Q2s+ Q5o+ J3s+ J7o+ T6s+ T8o+ 96s+ 98o 86s+ 76s',
    5:  '22+ A2s+ A2o+ K2s+ K2o+ Q2s+ Q5o+ J4s+ J7o+ T6s+ T8o+ 96s+ 98o 86s+ 76s',
    6:  '22+ A2s+ A2o+ K2s+ K2o+ Q2s+ Q6o+ J5s+ J8o+ T6s+ T8o+ 96s+ 86s+ 76s 65s',
    7:  '22+ A2s+ A2o+ K2s+ K2o+ Q2s+ Q8o+ J5s+ J8o+ T6s+ T9o 96s+ 86s+ 75s+ 65s 54s',
    8:  '22+ A2s+ A2o+ K2s+ K3o+ Q3s+ Q8o+ J6s+ J9o+ T6s+ T9o 96s+ 86s+ 75s+ 65s 54s',
    9:  '22+ A2s+ A2o+ K2s+ K4o+ Q3s+ Q8o+ J6s+ J9o+ T6s+ T9o 96s+ 86s+ 75s+ 65s 54s',
    10: '22+ A2s+ A2o+ K2s+ K5o+ Q4s+ Q9o+ J7s+ J9o+ T6s+ T9o 96s+ 86s+ 75s+ 65s 54s',
    11: '22+ A2s+ A2o+ K2s+ K7o+ Q5s+ Q9o+ J7s+ J9o+ T6s+ T9o 96s+ 86s+ 75s+ 65s 54s',
    12: '22+ A2s+ A2o+ K2s+ K8o+ Q5s+ Q9o+ J7s+ JTo T6s+ T9o 96s+ 86s+ 75s+ 65s 54s',
    13: '22+ A2s+ A2o+ K2s+ K9o+ Q6s+ QTo+ J7s+ J9o+ T7s+ T9o 96s+ 86s+ 75s+ 65s 54s',
    14: '22+ A2s+ A2o+ K4s+ K9o+ Q6s+ QTo+ J7s+ JTo T7s+ T9o 96s+ 86s+ 75s+ 65s',
    15: '22+ A2s+ A2o+ K4s+ K9o+ Q6s+ QTo+ J7s+ JTo T7s+ T9o 96s+ 86s+ 75s+ 65s',
  },

  'CO': {
    1:  '22+ 82s+ 82o+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 72s+ 73o+ 62s+ 63o+ 52s+ 53o+ 42s+ 43o 32s',
    2:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T4o+ 92s+ 95o+ 82s+ 85o+ 73s+ 75o+ 63s+ 65o 52s+ 43s',
    3:  '22+ K2s+ K2o+ A2s+ A2o+ Q2s+ Q5o+ J3s+ J7o+ T5s+ T7o+ 95s+ 97o+ 85s+ 87o 75s+ 65s 54s',
    4:  '22+ A2s+ A2o+ K2s+ K4o+ Q2s+ Q8o+ J5s+ J8o+ T6s+ T8o+ 96s+ 86s+ 76s',
    5:  '22+ A2s+ A2o+ K2s+ K5o+ Q3s+ Q8o+ J6s+ J9o+ T7s+ T9o 97s+ 86s+ 76s',
    6:  '22+ A2s+ A2o+ K2s+ K6o+ Q5s+ Q9o+ J7s+ J9o+ T7s+ T9o 97s+ 86s+ 76s 65s',
    7:  '22+ A2s+ A2o+ K2s+ K7o+ Q5s+ Q9o+ J7s+ J9o+ T7s+ T9o 97s+ 86s+ 76s 65s',
    8:  '22+ A2s+ A2o+ K2s+ K8o+ Q6s+ QTo+ J7s+ JTo T7s+ T9o 97s+ 86s+ 76s 65s',
    9:  '22+ A2s+ A2o+ K3s+ K9o+ Q6s+ QTo+ J7s+ JTo T7s+ 97s+ 86s+ 76s 65s',
    10: '22+ A2s+ A2o+ K4s+ K9o+ Q8s+ QTo+ J8s+ JTo T7s+ 97s+ 86s+ 76s 65s',
    11: '22+ A2s+ A2o+ K5s+ KTo+ Q8s+ QTo+ J8s+ JTo T7s+ 97s+ 86s+ 76s 65s',
    12: '22+ A2s+ A2o+ K5s+ KTo+ Q8s+ QTo+ J8s+ JTo T7s+ 97s+ 86s+ 76s',
    13: '22+ A2s+ A2o+ K6s+ KTo+ Q8s+ QTo+ J8s+ JTo T8s+ 97s+ 87s 76s',
    14: '22+ A2s+ A4o+ K7s+ KTo+ Q8s+ QTo+ J8s+ JTo T8s+ 97s+ 87s 76s',
    15: '22+ A2s+ A4o+ K7s+ KTo+ Q8s+ QTo+ J8s+ JTo T8s+ 97s+ 87s',
  },

  'HJ': {
    1:  '22+ 82s+ 82o+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 72s+ 73o+ 62s+ 63o+ 52s+ 52o+ 42s+ 43o 32s',
    2:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T3o+ 92s+ 95o+ 82s+ 85o+ 72s+ 75o+ 62s+ 64o+ 52s+ 54o 42s+ 32s',
    3:  '22+ A2s+ A2o+ K2s+ K3o+ Q2s+ Q6o+ J3s+ J8o+ T5s+ T8o+ 96s+ 98o 85s+ 75s+ 65s 54s',
    4:  '22+ A2s+ A2o+ K2s+ K6o+ Q4s+ Q8o+ J7s+ J9o+ T7s+ T9o 97s+ 86s+ 76s',
    5:  '22+ A2s+ A2o+ K2s+ K7o+ Q5s+ Q9o+ J7s+ J9o+ T7s+ 97s+ 87s 76s',
    6:  '22+ A2s+ A2o+ K3s+ K8o+ Q6s+ Q9o+ J8s+ JTo T8s+ 97s+ 87s 76s',
    7:  '22+ A2s+ A2o+ K4s+ K9o+ Q8s+ QTo+ J8s+ JTo T8s+ 97s+ 87s 76s',
    8:  '22+ A2s+ A2o+ K5s+ KTo+ Q8s+ QTo+ J8s+ JTo T8s+ 97s+ 87s 76s',
    9:  '22+ A2s+ A2o+ K6s+ KTo+ Q9s+ QTo+ J8s+ JTo T8s+ 97s+ 87s 76s',
    10: '22+ A2s+ A3o+ K7s+ KTo+ Q9s+ QTo+ J8s+ JTo T8s+ 97s+ 87s 76s',
    11: '22+ A2s+ A5o+ K7s+ KTo+ Q8s+ QJo J8s+ JTo T8s+ 98s 87s',
    12: '22+ A2s+ A7o+ A5o K8s+ KTo+ Q8s+ QJo J8s+ JTo T8s+ 98s 87s',
    13: '22+ A2s+ A7o+ A5o K8s+ KJo+ Q9s+ QJo J8s+ JTo T8s+ 98s 87s',
    14: '22+ A2s+ A8o+ K8s+ KJo+ Q9s+ QJo J8s+ JTo T8s+ 98s 87s',
    15: '22+ A2s+ A9o+ K8s+ KJo+ Q9s+ QJo J8s+ T8s+ 98s 87s',
  },

  'LJ': {
    1:  '22+ 82s+ 82o+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 72s+ 73o+ 62s+ 63o+ 52s+ 52o+ 42s+ 43o 32s',
    2:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T3o+ 92s+ 95o+ 82s+ 85o+ 72s+ 74o+ 62s+ 64o+ 52s+ 54o 42s+ 32s',
    3:  '22+ A2s+ A2o+ K2s+ K4o+ Q2s+ Q7o+ J3s+ J8o+ T6s+ T8o+ 96s+ 98o 85s+ 75s+ 64s+ 54s',
    4:  '22+ A2s+ A2o+ K2s+ K7o+ Q5s+ Q9o+ J7s+ J9o+ T7s+ T9o 97s+ 87s 76s',
    5:  '22+ A2s+ A2o+ K3s+ K9o+ Q8s+ QTo+ J8s+ JTo T8s+ 98s 87s',
    6:  '22+ A2s+ A2o+ K5s+ K9o+ Q8s+ QTo+ J8s+ JTo T8s+ 98s 87s',
    7:  '22+ A2s+ A3o+ K6s+ KTo+ Q8s+ QTo+ J8s+ JTo T8s+ 98s 87s',
    8:  '22+ A2s+ A4o+ K6s+ KTo+ Q9s+ QJo J8s+ T8s+ 98s 87s',
    9:  '22+ A2s+ A7o+ A5o K7s+ KTo+ Q9s+ QJo J8s+ T8s+ 98s 87s',
    10: '22+ A2s+ A7o+ K9s+ KTo+ Q9s+ QJo J8s+ T8s+ 98s 87s',
    11: '22+ A2s+ A8o+ K8s+ KJo+ Q9s+ QJo J8s+ T8s+ 98s 87s',
    12: '22+ A2s+ A9o+ K8s+ KJo+ Q9s+ QJo J8s+ T8s+ 98s',
    13: '22+ A3s+ A9o+ K9s+ KJo+ Q9s+ QJo J8s+ T8s+ 98s',
    14: '22+ A3s+ ATo+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    15: '33+ A4s+ ATo+ K9s+ KJo+ Q9s+ QJo J9s+ T9s 98s',
  },

  'UTG+3': {
    1:  '22+ 82s+ 82o+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 72s+ 73o+ 62s+ 63o+ 52s+ 52o+ 42s+ 43o 32s',
    2:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T3o+ 92s+ 95o+ 82s+ 85o+ 72s+ 74o+ 62s+ 64o+ 52s+ 54o 42s+ 32s',
    3:  '22+ A2s+ A2o+ K2s+ K4o+ Q2s+ Q8o+ J3s+ J8o+ T6s+ T8o+ 96s+ 98o 85s+ 74s+ 64s+ 53s+',
    4:  '22+ A2s+ A3o+ K3s+ K9o+ Q6s+ Q9o+ J7s+ JTo T7s+ 97s+ 87s 76s',
    5:  '22+ A2s+ A4o+ K5s+ K9o+ Q8s+ QTo+ J8s+ JTo T8s+ 98s 87s',
    6:  '22+ A2s+ A4o+ K6s+ KTo+ Q9s+ QTo+ J9s+ T8s+ 98s 87s',
    7:  '22+ A2s+ A7o+ A5o K7s+ KTo+ Q9s+ QJo J9s+ T8s+ 98s 87s',
    8:  '22+ A2s+ A7o+ K9s+ KTo+ Q9s+ QJo J9s+ T8s+ 98s 87s',
    9:  '22+ A2s+ A8o+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    10: '22+ A2s+ A9o+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    11: '22+ A4s+ ATo+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    12: '33+ A3s+ ATo+ K9s+ KJo+ Q9s+ J9s+ T8s+ 98s',
    13: '33+ A7s+ A4s A5s ATo+ K9s+ KJo+ Q9s+ J9s+ T9s',
    14: '33+ A7s+ A5s ATo+ K9s+ KJo+ Q9s+ J9s+ T9s',
    15: '33+ A8s+ A5s ATo+ K9s+ KQo Q9s+ J9s+ T9s',
  },

  'UTG+2': {
    1:  '22+ 82s+ 82o+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 72s+ 73o+ 62s+ 63o+ 52s+ 52o+ 42s+ 43o 32s',
    2:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T3o+ 92s+ 95o+ 82s+ 85o+ 72s+ 74o+ 62s+ 64o+ 52s+ 54o 42s+ 32s',
    3:  '22+ A2s+ A2o+ K2s+ K4o+ Q2s+ Q8o+ J3s+ J8o+ T6s+ T8o+ 96s+ 98o 85s+ 74s+ 64s+ 53s+',
    4:  '22+ A2s+ A3o+ K3s+ K9o+ Q6s+ Q9o+ J7s+ JTo T7s+ 97s+ 87s 76s',
    5:  '22+ A2s+ A4o+ K5s+ K9o+ Q8s+ QTo+ J8s+ JTo T8s+ 98s 87s',
    6:  '22+ A2s+ A4o+ K6s+ KTo+ Q9s+ QTo+ J9s+ T8s+ 98s 87s',
    7:  '22+ A2s+ A7o+ A5o K7s+ KTo+ Q9s+ QJo J9s+ T8s+ 98s 87s',
    8:  '22+ A2s+ A7o+ K9s+ KTo+ Q9s+ QJo J9s+ T8s+ 98s 87s',
    9:  '22+ A2s+ A8o+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    10: '22+ A2s+ A9o+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    11: '22+ A4s+ ATo+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    12: '33+ A3s+ ATo+ K9s+ KJo+ Q9s+ J9s+ T8s+ 98s',
    13: '33+ A7s+ A4s A5s ATo+ K9s+ KJo+ Q9s+ J9s+ T9s',
    14: '33+ A7s+ A5s ATo+ K9s+ KJo+ Q9s+ J9s+ T9s',
    15: '33+ A8s+ A5s ATo+ K9s+ KQo Q9s+ J9s+ T9s',
  },

  'UTG+1': {
    1:  '22+ 82s+ 82o+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 72s+ 73o+ 62s+ 63o+ 52s+ 52o+ 42s+ 43o 32s',
    2:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T3o+ 92s+ 95o+ 82s+ 85o+ 72s+ 74o+ 62s+ 64o+ 52s+ 54o 42s+ 32s',
    3:  '22+ A2s+ A2o+ K2s+ K5o+ Q2s+ Q8o+ J3s+ J8o+ T6s+ T8o+ 95s+ 98o 85s+ 74s+ 64s+ 53s+',
    4:  '22+ A2s+ A4o+ K4s+ K9o+ Q8s+ QTo+ J8s+ JTo T8s+ 97s+ 87s 76s',
    5:  '22+ A2s+ A5o+ K6s+ KTo+ Q8s+ QTo+ J9s+ T8s+ 98s',
    6:  '22+ A2s+ A7o+ K7s+ KTo+ Q9s+ QJo J9s+ T8s+ 98s',
    7:  '22+ A2s+ A8o+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    8:  '22+ A2s+ A9o+ K9s+ KJo+ Q9s+ J9s+ T8s+ 98s',
    9:  '22+ A3s+ A9o+ K9s+ KJo+ Q9s+ QJo J9s+ T8s+ 98s',
    10: '33+ A4s+ ATo+ K9s+ KJo+ Q9s+ J9s+ T9s 98s',
    11: '33+ A7s+ A4s A5s ATo+ K9s+ KJo+ Q9s+ J9s+ T9s',
    12: '33+ A8s+ A5s ATo+ K9s+ KQo Q9s+ J9s+ T9s',
    13: '44+ A8s+ A5s ATo+ K9s+ KQo Q9s+ J9s+ T9s',
    14: '44+ A8s+ A5s AJo+ K9s+ KQo Q9s+ J9s+ T9s',
    15: '44+ A9s+ A5s AJo+ K9s+ KQo QTs+ JTs T9s',
  },

  'UTG': {
    1:  '22+ 82s+ 82o+ 92s+ 92o+ T2s+ T2o+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ 72s+ 73o+ 62s+ 63o+ 52s+ 52o+ 42s+ 43o 32s',
    2:  '22+ J2s+ J2o+ Q2s+ Q2o+ K2s+ K2o+ A2s+ A2o+ T2s+ T3o+ 92s+ 95o+ 82s+ 85o+ 72s+ 74o+ 62s+ 64o+ 52s+ 54o 42s+ 32s',
    3:  '22+ A2s+ A2o+ K2s+ K5o+ Q2s+ Q8o+ J3s+ J8o+ T6s+ T8o+ 95s+ 98o 85s+ 74s+ 64s+ 53s+',
    4:  '22+ A2s+ A5o+ K5s+ K9o+ Q8s+ QTo+ J8s+ JTo T8s+ 98s 87s 76s',
    5:  '22+ A2s+ A7o+ K7s+ KTo+ Q9s+ QJo J9s+ T9s 98s',
    6:  '22+ A2s+ A8o+ K8s+ KTo+ Q9s+ J9s+ T9s 98s',
    7:  '33+ A2s+ A9o+ K9s+ KJo+ Q9s+ J9s+ T9s 98s',
    8:  '33+ A3s+ ATo+ K9s+ KJo+ Q9s+ J9s+ T9s 98s',
    9:  '33+ A7s+ A4s A5s ATo+ K9s+ KQo Q9s+ J9s+ T9s',
    10: '33+ A7s+ A5s ATo+ K9s+ KQo Q9s+ J9s+ T9s',
    11: '44+ A8s+ A5s ATo+ K9s+ KQo Q9s+ J9s+ T9s',
    12: '44+ A8s+ AJo+ K9s+ KQo Q9s+ J9s+ T9s',
    13: '55+ A9s+ A5s AJo+ K9s+ KQo QTs+ JTs T9s',
    14: '55+ A9s+ A5s AJo+ KTs+ KQo QTs+ JTs',
    15: '55+ A9s+ A5s AJo+ KTs+ QTs+ JTs',
  },
};
