import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/word.dart';
import '../repositories/repository_providers.dart';

class WordListNotifier extends AsyncNotifier<List<Word>> {

  @override
  Future<List<Word>> build() async {
    final repository = ref.read(wordRepositoryProvider);
   
    final saved = await repository.loadWords();
    
    //Exemplos para 1º caso de uso:
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
    final repository = ref.read(wordRepositoryProvider);
    final wordWithId = await repository.insertWord(word); //salve e recebe id
    final currentWords = state.value ?? [];
    state = AsyncData([...currentWords, wordWithId]); //atualiza tela com id certo
    
  }

  Future<void> removeWord(int id) async{
    final repository = ref.read(wordRepositoryProvider);
    await repository.deleteWord(id);
    final currentWords = state.value ?? [];
    state = AsyncData(
      currentWords.where((word) => word.id != id).toList(),
    );
  }
}

final wordListProvider = AsyncNotifierProvider<WordListNotifier, List<Word>>(WordListNotifier.new);