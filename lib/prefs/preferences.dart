import 'dart:async';

import 'preferences_base.dart';

class Prefs {
  static Future<String> get deviceStatus => PreferencesHelper.getString(Const.DEVICE_STATUS);

  static Future setDeviceStatus(String value) => PreferencesHelper.setString(Const.DEVICE_STATUS, value);

  static Future<void> clear() async {
    await Future.wait(<Future>[
      setDeviceStatus(''),
    ]);
  }
}

class Const {
  static const String DEVICE_STATUS = 'DEVICE_STATUS';
}