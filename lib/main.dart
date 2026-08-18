import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/word_list_screen.dart';

void main(){
    runApp(
        const ProviderScope( 
            child:  VocabApp()
        ),
    );
}

class VocabApp extends StatelessWidget {
    const VocabApp({super.key});

    @override
    Widget build(BuildContext context){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Vocab',
            home: const WordListScreen(),
        );
    }
}