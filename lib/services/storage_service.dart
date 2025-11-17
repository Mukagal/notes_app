import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mini_app/models/note.dart';

class StorageService {
  static const String key = "notes";

  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = notes.map((n) => n.toJson()).toList();
    await prefs.setString(key, jsonEncode(jsonList));
  }

  static Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];

    final data = jsonDecode(jsonString) as List<dynamic>;
    return data.map((json) => Note.fromJson(json)).toList();
  }
}
