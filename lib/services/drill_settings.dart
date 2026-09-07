import 'package:flutter/foundation.dart';

//Holds the currently selected ante level, used to generate new drill spots and decide on right chart
class DrillSettings {
  static final ValueNotifier<String> anteLevel = ValueNotifier<String>('0');
}
