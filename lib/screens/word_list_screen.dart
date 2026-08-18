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
  //final WordRepository _repository = WordRepository();

  /*
  final List<Word> words = [
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
  */

  final TextEditingController _termController = TextEditingController();
  final TextEditingController _meaningController = TextEditingController();

  
  // Future<void> _saveWords() async {
  //   await _repository.saveWords(words);
  // }

  // Future<void> _loadWords() async {
  //   final loadedWords = await _repository.loadWords();
  //   setState(() {
  //     words.clear();
  //     words.addAll(loadedWords);
  //   });
  // }
  

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

    //_saveWords();
  }

  void _removeWord(int i){
    ref.read(wordListProvider.notifier).removeWord(i);
    //_saveWords();
  }

  @override
  void initState() {
    super.initState();
    //_loadWords();
    //_repository.clearAll();
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

/*
setState(() {
    words.add(
        const Word(term: 'isomorphism', meaning: 'a structure-preserving map between two mathematical structures', example: 'The mineral showed an isomorphism with the crystal structure of the other sample'),
    );
    
    words.insert(
        0, (const Word(term: 'X', meaning: 'Y', example: 'Z'))
    );
    
});
*/

/*
Future<void> _saveWords() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = words.map((word) => word.toJson()).toList();
  final jsonString = jsonEncode(jsonList);
  await prefs.setString('words', jsonString);
}

Future<void> _loadWords() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('words');
  if (jsonString == null) return; 

  final jsonList = jsonDecode(jsonString) as List<dynamic>;
  final loadedWords = jsonList.map((item) => Word.fromJson(item as Map<String, dynamic>)).toList();

  setState(() {
    words.clear();
    words.addAll(loadedWords);
  });
}
*/

/*
Future<void> _saveWords() async {
    await _repository.saveWords(words);
  }

  Future<void> _loadWords() async {
    final loadedWords = await _repository.loadWords();
    setState(() {
      words.clear();
      words.addAll(loadedWords);
    });
  }
  

  void _addWord() {
    final typedTerm = _termController.text;
    final typedMeaning = _meaningController.text;

    if (typedTerm.isEmpty) return;
    if (typedMeaning.isEmpty) return; //TODO: colocar snackar caso meaning venha vazio explicando o porquê de não salvar.

    setState(() {
      words.add(
        Word(term: typedTerm, meaning: typedMeaning, example: '-'),
      );
    });

    _termController.clear();
    _meaningController.clear();

    _saveWords();
  }

  void _removeWord(int i){
    setState(() {
      words.removeAt(i);
    });
    _saveWords();
  }
  */

  /*
  Expanded(
          child: ListView.builder(
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
  */