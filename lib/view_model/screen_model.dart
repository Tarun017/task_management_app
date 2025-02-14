import 'package:flutter/material.dart';


class ScreenModel with ChangeNotifier {
// Dark Mode:
  bool _offlineMode = false;

  get offlineMode => _offlineMode;

  toggleMode() {
    _offlineMode = !_offlineMode;

    notifyListeners();
  }

}
