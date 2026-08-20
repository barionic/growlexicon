import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'word_repository.dart';
import 'sqlite_word_repository.dart';

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return SqliteWordRepository();  
});