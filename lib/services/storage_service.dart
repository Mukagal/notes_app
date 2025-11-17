import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_app/models/note.dart';

class StorageService {
  static const String key = "Notes list";

  static Future<void> saveNotes(List<Note> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data);
    await prefs.setString(key, jsonString);
  }

  static Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    final data = jsonDecode(jsonString) as List<Note>;
    return data;
  }
}
