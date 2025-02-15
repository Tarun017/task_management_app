import 'package:flutter/material.dart';
class ScreenModel with ChangeNotifier {
// Dark Mode:
  bool _offlineMode = true;

  get offlineMode => _offlineMode;

  toggleMode() async {
    _offlineMode = !_offlineMode;
    notifyListeners();
  }

}
