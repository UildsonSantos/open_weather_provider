import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'temp_settings_state.dart';

class TempSettingsProvider with ChangeNotifier {
  TempSettingsState _state = TempSettingsState.initial();
  TempSettingsState get state => _state;

  void tongleTempUnit() {
    _state = _state.copyWith(
      tempUnit: _state.tempUnit == TempUnit.celsius
          ? TempUnit.fahrenheit
          : TempUnit.celsius,
    );
    notifyListeners();
  }
}
