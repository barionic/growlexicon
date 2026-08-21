import 'package:drift/drift.dart';
import '../database/drift_database.dart' as drift;
import '../models/word.dart';
import 'word_repository.dart';

class DriftWordRepository implements WordRepository{
  final drift.AppDatabase _db = drift.AppDatabase();

  @override
  Future<List<Word>> loadWords() async{
    final rows = await _db.select(_db.words).get();
    return rows.map((row) => Word(
      id: row.id,
      term: row.term,
      meaning: row.meaning,
      example: row.example ?? '-',
    )).toList();
  }

  @override
  Future<Word> insertWord(Word word) async{
    final id = await _db.into(_db.words).insert(
      drift.WordsCompanion.insert(
        term: word.term, 
        meaning: word.meaning,  
        example: Value(word.example),
      ),
    );
    return Word(
      id: id,
      term: word.term,
      meaning: word.meaning,
      example: word.example
    );
  }

  @override
  Future<void> deleteWord(int id) async {
    await (_db.delete(_db.words)..where((tbl) => tbl.id.equals(id))).go();
  }
}