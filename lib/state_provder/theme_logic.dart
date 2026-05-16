import 'package:flutter/material.dart';

class ThemeLogic extends ChangeNotifier {
  bool _isLight = true;
  bool get isLight => _isLight;

  void toggleToSwitchMode() {
    _isLight = !_isLight;
    notifyListeners();
  }
}
