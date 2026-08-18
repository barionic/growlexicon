import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growlexicon/providers/word_list_provider.dart';
import 'package:growlexicon/models/word.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main (){
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  //addWord
  test('addWord - adiciona uma palavra ao estado', () async {
    //Arrange - prepara o cenário 
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(wordListProvider.future);
    final notifier = container.read(wordListProvider.notifier);

    final tamanhoInicial = container.read(wordListProvider).value!.length;

    //Act - executa a ação
    notifier.addWord(
      const Word(term: 'test', meaning: 'a trial', example: 'This is a test'),
    );

    //Assert - verifica o resultado 
    final tamanhoFinal = container.read(wordListProvider).value!.length;
    expect(tamanhoFinal, tamanhoInicial+1);

  });

  //removeWord
  test('removeWord - remove uma palavra do estado', () async {
    //Arrange - prepara o cenário 
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(wordListProvider.future);
    final notifier = container.read(wordListProvider.notifier);

    notifier.addWord(
      const Word(term: 'temp', meaning: 'temporary', example: 'A temp word.'),
    );
    final tamanhoInicial = container.read(wordListProvider).value!.length;

    //Act - executa a ação
    notifier.removeWord(0);

    //Assert - verifica o resultado 
    final tamanhoFinal = container.read(wordListProvider).value!.length;
    expect(tamanhoFinal, tamanhoInicial-1);

  });
}