import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Service class for managing SharedPreferences
class SharedPreferencesServiceImpl {

  /// SharedPreferences instance
  late SharedPreferences prefs;

  /// Initialize the SharedPreferences instance
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Add a boolean value to SharedPreferences
  Future<void> addBoolean(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  /// Retrieve a boolean value from SharedPreferences
  Future<bool> getBoolean(String key) async => prefs.getBool(key) ?? false;

  /// Add an integer value to SharedPreferences
  Future<void> addInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  /// Retrieve an integer value from SharedPreferences
  Future<int> getInt(String key) async => prefs.getInt(key) ?? 0;

  /// Add a string value to SharedPreferences
  Future<void> addString(String key, String value) async {
    await prefs.setString(key, value);
  }

  /// Retrieve a string value from SharedPreferences
  Future<String> getString(String key) async => prefs.getString(key) ?? "";

  /// Add a double value to SharedPreferences
  Future<void> addDouble(String key, double value) async {
    await prefs.setDouble(key, value);
  }

  /// Retrieve a double value from SharedPreferences
  Future<double> getDouble(String key) async => prefs.getDouble(key) ?? 0.0;

  /// Save a custom object as a JSON string in SharedPreferences
  Future<void> addObject<T>(String key, T object, Map<String, dynamic> Function(T) toJson) async {
    final jsonString = jsonEncode(toJson(object));
    await prefs.setString(key, jsonString);
  }

  /// Retrieve a custom object from a JSON string in SharedPreferences
  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return fromJson(jsonMap);
  }

  void clearSharedPreferenceData(){
    prefs.clear();
  }

  /// remove value from SharedPreferences
  Future<void> remove(String key) async {
    await prefs.remove(key);
  }
}
