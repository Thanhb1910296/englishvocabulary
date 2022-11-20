import 'dart:convert';

class Word {
  final String name;
  final String description;
  final String translate;
  final String favorite;
  final String? id;

  Word ({
    required this.name,
    required this.description,
    required this.translate,
    required this.favorite,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'translate': translate,
      'favorite': favorite,
      'id': id,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      translate: map['translate'] ?? '',
      favorite: map['favorite'] ?? '',
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) => Word.fromMap(json.decode(source));
}