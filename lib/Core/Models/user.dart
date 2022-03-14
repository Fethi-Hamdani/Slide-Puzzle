import 'dart:convert';

import 'package:slidepuzzle/Core/Models/score.dart';

class User {
  String? id;
  Score score;
  String? name;
  User({
    required this.id,
    required this.score,
    this.name,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'score': score.toMap(),
      'name': name,
    };
    if (name == null || name!.isEmpty) {
      map.remove('name');
    }

    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      score: Score.fromMap(map['score']),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
