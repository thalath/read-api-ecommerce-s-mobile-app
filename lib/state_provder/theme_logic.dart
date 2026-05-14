import 'package:flutter/material.dart';

class KConstants {
  static const String themeModeKey = 'themeModeKey';
}

class ThemeLogic extends ChangeNotifier {
  bool _isLight = true;
  bool get isLight => _isLight;

  void darkTheme() {
    _isLight = true;
    notifyListeners();
  }

  void lightTheme() {
    _isLight = false;
    notifyListeners();
  }
}
