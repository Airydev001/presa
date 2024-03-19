import 'dart:convert';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreference;
  PrefUtils() {
    //init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreference = value;
    });
  }

  Future<void> init() async {
    _sharedPreference ??= await SharedPreferences.getInstance();
    print("SharedPreference Initialized");
  }

  // will clear all data stored in preference

  void clearPreferencesData() async {
    _sharedPreference!.clear();
  }

  Future<void> setThemeData(String value) {
    return _sharedPreference!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreference!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }
}
