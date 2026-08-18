import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/word.dart';
import '../repositories/word_repository.dart';

class WordListNotifier extends AsyncNotifier<List<Word>> {
  final WordRepository _repository = WordRepository();

  @override
  Future<List<Word>> build() async {
    //Se quiser que venha lista vazia, apaga tudo do build() e deixa SÓ a linha debaixo descomentada.
    //return _repository.loadWords();
    final saved = await _repository.loadWords();
    
    //Se for 1º caso de uso:
    if (saved.isEmpty){
      return [
        const Word(
          term: 'ephemeral',
          meaning: 'lasting a very short time',
          example: 'Fame is often ephemeral.'
        ),
        const Word(
          term: 'serendipity',
          meaning: 'a pleasant surprise found by chance',
          example: 'Meeting her was pure serendipity.'
        ),
        const Word(
          term: 'petrichor',
          meaning: 'the smell of earth after rain',
          example: 'The petrichor filled the air.'
        ),
      ];
    }
    return saved;
  }

  Future<void> addWord(Word word) async{
    final currentWords = state.value ?? [];
    final newWords = [...currentWords, word];
    state = AsyncData(newWords);
    await _repository.saveWords(newWords);
  }

  Future<void> removeWord(int index) async{
    final currentWords = state.value ?? [];
    final newWords = [
      for(int i=0; i<currentWords.length; i++)
        if (i != index) currentWords[i],
    ];
    state = AsyncData(newWords);
    await _repository.saveWords(newWords);
  }

}

final wordListProvider = AsyncNotifierProvider<WordListNotifier, List<Word>>(WordListNotifier.new);