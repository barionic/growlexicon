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
  Future<Word> insertWord(Word word) async {
    final db = await _dbHelper.database;
    final id = await db.insert('words', word.toJson());
    return Word(
      id: id,
      term: word.term,
      meaning: word.meaning,
      example: word.example,
    );
  }

  @override
  Future<void> deleteWord(int id) async {
    final db = await _dbHelper.database;
    await db.delete('words', where: 'id = ?', whereArgs: [id]);
  }
}