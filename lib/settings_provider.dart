// Readable, private settings
// Controlled changes
// Automatic UI updates using Provider

import 'package:flutter/foundation.dart'; // required for ChangeNotifier


class SettingsProvider with ChangeNotifier {
  bool _largeText = false;
  bool _highContrast = false; 

  bool get largeText => _largeText; // getter
  bool get highContrast => _highContrast; 

  void toggleLargeText(bool value) {
    _largeText = value;
    notifyListeners();
  }

  void toggleHighContrast(bool value) {
    _highContrast = value;
    notifyListeners();
  }
}
