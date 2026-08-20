import '../models/word.dart';

abstract class WordRepository {
  Future<List<Word>> loadWords();

  Future<Word> insertWord(Word word);
  Future<void> deleteWord(int id);

  //Future<void> saveWords(List<Word> words);  
}