import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/word_list_provider.dart';
import '../models/word.dart';
import '../widgets/word_text_field.dart';

class WordListScreen extends ConsumerStatefulWidget{
  const WordListScreen({super.key});

  @override
  ConsumerState<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends ConsumerState<WordListScreen> {
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _meaningController = TextEditingController();

  void _addWord() {
    final typedTerm = _termController.text;
    final typedMeaning = _meaningController.text;

    if (typedTerm.isEmpty) return;
    if (typedMeaning.isEmpty) return; //TODO: colocar snackar caso meaning venha vazio explicando o porquê de não salvar.

    ref.read(wordListProvider.notifier).addWord(
      Word(term: typedTerm, meaning: typedMeaning, example: '-'),
    );

    _termController.clear();
    _meaningController.clear();
  }

  void _removeWord(int i){
    ref.read(wordListProvider.notifier).removeWord(i);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _termController.dispose();
    _meaningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final wordsAsync = ref.watch(wordListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('My Words')),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWord,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          WordTextField(
            controller: _termController, 
            label: 'Brave New Word',
          ),
          WordTextField(
            controller: _meaningController, 
            label: 'Brave New Meaning'
          ),
          Expanded(
            child: wordsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Erro: $err')),
              data: (words) => ListView.builder(
              itemCount: words.length,
                itemBuilder: (context, index) {
                  final word = words[index];
                  return ListTile(
                    title: Text(word.term),
                    subtitle: Text(word.meaning),
                    onLongPress: () => _removeWord(index)
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }    
}