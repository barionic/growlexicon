import '../database/database_helper.dart';
import '../models/word.dart';
import 'word_repository.dart';

class SqliteWordRepository implements WordRepository{
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Future<List<Word>> loadWords() async {
    final db = await _dbHelper.database;
    final maps = await db.query('words');
    return maps.map((map) => Word.fromJson(map)).toList();
  }

  @override
  Future<void> saveWords(List<Word> words) async {
    final db = await _dbHelper.database;
    await db.delete('words');
    for (final word in words){
      await db.insert('words', word.toJson());
    }
  }
}