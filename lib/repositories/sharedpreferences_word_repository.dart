import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word.dart';
import 'word_repository.dart';

class SharedPreferencesWordRepository implements WordRepository {
  static const _storageKey = 'words';

  @override
  Future<List<Word>> loadWords() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];

    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList.map((item) => Word.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Future<Word> insertWord(Word word) async {
    final list = await loadWords();
    final nextId = list.isEmpty ? 1 : list.map((w) => w.id ?? 0).reduce((a,b) => a > b ? a : b) + 1;
    final wordWithId = Word(
      id: nextId,
      term: word.term,
      meaning: word.meaning,
      example: word.example
    );
    final newList = [...list, wordWithId];
    await _saveAll(newList);
    return wordWithId;
  }

  @override
  Future<void> deleteWord(int id) async {
    final list = await loadWords();
    final newList = list.where((word) => word.id != id).toList();
    await _saveAll(newList);
  }

  Future<void> _saveAll(List<Word> words) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = words.map((word) => word.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }
}