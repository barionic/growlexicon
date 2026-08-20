import '../models/word.dart';

abstract class WordRepository {
  Future<List<Word>> loadWords();  
  Future<void> saveWords(List<Word> words);  
}