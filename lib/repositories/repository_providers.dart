import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growlexicon/repositories/drift_word_repository.dart';
import 'word_repository.dart';
import 'sqlite_word_repository.dart';
import 'sharedpreferences_word_repository.dart';

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return SqliteWordRepository();  
  //return SharedPreferencesWordRepository();
  //return DriftWordRepository(); 
});