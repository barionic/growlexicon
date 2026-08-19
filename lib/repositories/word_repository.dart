import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word.dart';

class WordRepository {
  static const _storageKey = 'words';

  Future<void> saveWords(List<Word> words) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = words.map((word) => word.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_storageKey, jsonString);
  }

  Future<List<Word>> loadWords() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];

    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList.map((item) => Word.fromJson(item as Map<String, dynamic>)).toList();
  }
}

final wordRepositoryProvider = Provider<WordRepository>((ref){
  return WordRepository();
});