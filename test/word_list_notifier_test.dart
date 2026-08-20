import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growlexicon/providers/word_list_provider.dart';
import 'package:growlexicon/models/word.dart';
import 'package:growlexicon/repositories/word_repository.dart';
import 'package:growlexicon/repositories/repository_providers.dart';

class FakeWordRepository implements WordRepository{
  List<Word> _words = [];

  @override
  Future<List<Word>> loadWords() async => _words;
  
  @override
  Future<Word> insertWord(Word word) async {
    final nextId =_words.isEmpty ? 1 : _words.map((w) => w.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    final wordWithId = Word(
      id: nextId,
      term: word.term,
      meaning: word.meaning,
      example: word.example
    );
    _words = [..._words, wordWithId];
    return wordWithId;
  }

  @override
  Future<void> deleteWord(int id) async {
    _words = _words.where((word) => word.id != id).toList();
  }

}

void main (){
  test('addWord - adiciona uma palavra ao estado', () async {
    //Arrange - prepara o cenário 
    final container = ProviderContainer(
      overrides: [
        wordRepositoryProvider.overrideWithValue(FakeWordRepository()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(wordListProvider.future);
    final notifier = container.read(wordListProvider.notifier);

    final tamanhoInicial = container.read(wordListProvider).value!.length;

    //Act - executa a ação
    await notifier.addWord(
      const Word(term: 'test', meaning: 'a trial', example: 'This is a test'),
    );

    //Assert - verifica o resultado 
    final tamanhoFinal = container.read(wordListProvider).value!.length;
    expect(tamanhoFinal, tamanhoInicial+1);

  });

  test('removeWord - remove uma palavra do estado', () async {
    //Arrange - prepara o cenário 
    final container = ProviderContainer(
      overrides: [
        wordRepositoryProvider.overrideWithValue(FakeWordRepository()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(wordListProvider.future);
    final notifier = container.read(wordListProvider.notifier);

    await notifier.addWord(
      const Word(term: 'temp', meaning: 'temporary', example: 'A temp word.'),
    );
    final wordsAfterAdd = container.read(wordListProvider).value!;
    final tamanhoInicial = wordsAfterAdd.length;
    final idParaRemover= wordsAfterAdd.last.id!;

    //Act - executa a ação
    await notifier.removeWord(idParaRemover);

    //Assert - verifica o resultado
    final tamanhoFinal = container.read(wordListProvider).value!.length;
    expect(tamanhoFinal, tamanhoInicial-1);

  });
}