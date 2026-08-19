class Word {
  final int? id;
  final String term;
  final String meaning;
  final String example;

  const Word({
    this.id,
    required this.term,
    required this.meaning,
    required this.example,
  });

  Map<String, dynamic> toJson() => {
    if(id != null) 'id': id,
    'term': term,
    'meaning': meaning,
    'example': example,
  };

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    id: json['id'] as int?,
    term: json['term'] as String, 
    meaning: json['meaning'] as String, 
    example: json['example'] as String,
  );
}