class Word {
  final String term;
  final String meaning;
  final String example;

  const Word({
    required this.term,
    required this.meaning,
    required this.example,
  });

  Map<String, dynamic> toJson() => {
    'term': term,
    'meaning': meaning,
    'example': example,
  };

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    term: json['term'] as String, 
    meaning: json['meaning'] as String, 
    example: json['example'] as String,
  );
}