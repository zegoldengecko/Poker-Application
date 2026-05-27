import 'package:flutter/material.dart';
import 'package:push_fold_main/data/stats_database.dart';
import 'package:push_fold_main/services/drill_generator.dart';
import 'package:push_fold_main/services/hand_parser.dart';
import 'package:push_fold_main/models/drill_spot.dart';
import 'package:push_fold_main/data/gto_charts.dart';
import 'package:push_fold_main/data/failure_database.dart';
import 'package:push_fold_main/data/stats_record.dart';
import 'dart:math';

class DrillScreen extends StatefulWidget {
  const DrillScreen({super.key});

  @override
  State<DrillScreen> createState() => _DrillScreenState();
}

class _DrillScreenState extends State<DrillScreen> {
  late DrillSpot spot;
  late List<Map<String, dynamic>> cards;
  bool? _flashCorrect;

  @override
  void initState() {
    super.initState();
    spot = generateRandomSpot();
    cards = parseHand(spot.hand);
  }

  // Advancing to next drill spot
  void nextSpot() {
    setState(() {
      spot = generateRandomSpot();
      cards = parseHand(spot.hand);
    });
  }

  // Checking if answer was correct and acts accordingly
  void submitAnswer(bool pushed, DrillSpot spot) {
    final correct = (pushed && shouldShove(spot)) || (!pushed && !shouldShove(spot));

    // Updating failure database
    if (correct) {
      failureDatabase.removeFailure(spot);
    } else {
      failureDatabase.recordFailure(spot);
    }

    // Updating stats database
    final record = StatsRecord(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      drillspot: spot,
      result: correct ? 1 : 0,
    );
    statsDatabase.recordResult(record);

    // Flashing green for correct and red for incorrect
    setState(() => _flashCorrect = correct);
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _flashCorrect = null);
        nextSpot();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Background flashes green or red briefly on answer
    Color backgroundColor = const Color(0xFF1a1f2e);
    if (_flashCorrect == true) backgroundColor = const Color(0xFF1a5c2a);
    if (_flashCorrect == false) backgroundColor = const Color(0xFF5c1a1a);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white54),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const Spacer(),

              // Poker table diagram
              _PokerTable(activePosition: spot.position),

              const Spacer(),

              const Text(
                'Your hole cards',
                style: TextStyle(fontSize: 20, color: Color(0xFF506070)),
              ),
              const SizedBox(height: 10),

              // Hole cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PlayingCard(
                    rank: cards[0]['rank'],
                    suit: cards[0]['suit'],
                    red: cards[0]['red'],
                  ),
                  const SizedBox(width: 14),
                  _PlayingCard(
                    rank: cards[1]['rank'],
                    suit: cards[1]['suit'],
                    red: cards[1]['red'],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Position and stack shown under hole cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _InfoBadge(label: 'Position', value: spot.position),
                  const SizedBox(width: 12),
                  _InfoBadge(label: 'Stack', value: '${spot.stack}bb'),
                ],
              ),

              const Spacer(),

              // Push / Fold buttons
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: 'Fold',
                      color: const Color(0xFFff8080),
                      background: const Color(0xFF3a2020),
                      border: const Color(0xFF6a3030),
                      hoverColor: const Color(0xFF6a3535),
                      onTap: () => submitAnswer(false, spot),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ActionButton(
                      label: 'Push',
                      color: const Color(0xFF60d080),
                      background: const Color(0xFF1a3a20),
                      border: const Color(0xFF2a6a30),
                      hoverColor: const Color(0xFF2a5a30),
                      onTap: () => submitAnswer(true, spot),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------- Widgets --------------------------

// Displays a labelled value badge e.g. "Position: BTN"
class _InfoBadge extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2a3050),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF3a4060), width: 0.5),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 17, color: Color(0xFFa0b0d0)),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(
              text: value,
              style: const TextStyle(color: Color(0xFFe0eaff), fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Displays a single playing card with rank and suit
class _PlayingCard extends StatelessWidget {
  final String rank;
  final String suit;
  final bool red;

  const _PlayingCard({required this.rank, required this.suit, required this.red});

  @override
  Widget build(BuildContext context) {
    final color = red ? const Color(0xFFcc2222) : const Color(0xFF111111);
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFdddddd), width: 0.5),
        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 6,
            child: Column(
              children: [
                Text(rank, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: color, height: 1.1)),
                Text(suit, style: TextStyle(fontSize: 20, color: color, height: 1.1)),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(rank, style: TextStyle(fontSize: 46, fontWeight: FontWeight.w600, color: color, height: 1)),
                Text(suit, style: TextStyle(fontSize: 42, color: color, height: 1.1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Push/Fold action button with hover effect
class _ActionButton extends StatefulWidget {
  final String label;
  final Color color;
  final Color background;
  final Color border;
  final Color hoverColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.color,
    required this.background,
    required this.border,
    required this.hoverColor,
    required this.onTap,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: _hovered ? widget.hoverColor : widget.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.border,
              width: _hovered ? 2.0 : 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: widget.color.withOpacity(_hovered ? 1.0 : 0.85),
            ),
          ),
        ),
      ),
    );
  }
}

// Renders an oval poker table with seat positions, highlighting the active seat
class _PokerTable extends StatelessWidget {
  final String activePosition;

  const _PokerTable({required this.activePosition});

  static const _positions = ['BTN', 'CO', 'HJ', 'LJ', '+3', '+2', '+1', 'UTG', 'BB', 'SB'];

  static const double tableW = 460;
  static const double tableH = 270;
  static const double seatR = 14;
  static const double chipOffsetScale = 0.62;

  @override
  Widget build(BuildContext context) {

    const rx = tableW / 2 + seatR + 2;
    const ry = tableH / 2 + seatR + 2;
    const cx = rx;
    const cy = ry;

    final totalW = cx * 2 + 120;
    final totalH = cy * 2 + 100;

    const offsetX = 5.0;
    const offsetY = 15.0;

    const nudges = <String, List<double>>{
      'SB':    [-12, -12],
      '+1': [-12, 12],
      'CO':    [12, -12],
      '+3': [12, 12],
    };

    return SizedBox(
      width: totalW,
      height: totalH,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, top: 60),
        child: Stack(
          children: [
            // Felt
            Positioned(
              left: seatR + 2 + offsetX,
              top: seatR + 2 + offsetY,
              child: Container(
                width: tableW,
                height: tableH,
                decoration: BoxDecoration(
                  color: const Color(0xFF1a6644),
                  borderRadius: BorderRadius.circular(tableH / 2),
                  border: Border.all(color: const Color(0xFF6b3a1f), width: 6),
                ),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: Colors.white.withOpacity(0.07), width: 1),
                    ),
                  ),
                ),
              ),
            ),

            // Community card spots
            Positioned(
              left: seatR + 2 + tableW / 2 - 5 * 22 / 2 + offsetX,
              top: seatR + 2 + tableH / 2 - 18 + offsetY,
              child: Row(
                children: List.generate(5, (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 18,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
                  ),
                )),
              ),
            ),

            // Seats placed around the table
            ..._positions.asMap().entries.map((entry) {
              final i = entry.key;
              final pos = entry.value;
              final angle = (2 * pi * i / _positions.length) - pi / 2;
              final nudge = nudges[pos] ?? [0.0, 0.0];
              final x = cx + offsetX + rx * cos(angle) - seatR + nudge[0];
              final y = cy + offsetY + ry * sin(angle) - seatR + nudge[1];
              final displayPos = pos; // what's shown in the seat
              final checkPos = pos == '+1' ? 'UTG+1' : pos == '+2' ? 'UTG+2' : pos == '+3' ? 'UTG+3' : pos;
              final isActive = checkPos == activePosition;

              final chipX = cx + rx * chipOffsetScale * cos(angle) - 7;
              final chipY = cy + ry * chipOffsetScale * sin(angle) - 7;

              return Stack(
                children: [
                  // Seat circle with label inside
                  Positioned(
                    left: x,
                    top: y,
                    child: Container(
                      width: seatR * 2,
                      height: seatR * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? const Color(0xFFe8b84b) : const Color(0xFF2a3a50),
                        border: Border.all(
                          color: isActive ? const Color(0xFFf5d080) : const Color(0xFF3a5070),
                          width: isActive ? 2 : 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          displayPos,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 7,
                            color: isActive ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // BTN dealer button
                  if (pos == 'BTN')
                    Positioned(
                      left: chipX + 5,
                      top: chipY - 10,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                        ),
                        child: const Center(
                          child: Text('D', style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: Colors.black)),
                        ),
                      ),
                    ),

                  // SB chip
                  if (pos == 'SB')
                    Positioned(
                      left: chipX - 35,
                      top: chipY - 22,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF4488ff),
                          border: Border.all(color: Colors.white24, width: 1),
                        ),
                        child: const Center(
                          child: Text('SB', style: TextStyle(fontSize: 5, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ),

                  // BB chip
                  if (pos == 'BB')
                    Positioned(
                      left: chipX - 45,
                      top: chipY,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFcc3333),
                          border: Border.all(color: Colors.white24, width: 1),
                        ),
                        child: const Center(
                          child: Text('BB', style: TextStyle(fontSize: 5, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
