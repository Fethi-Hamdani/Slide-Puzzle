import 'dart:convert';

class Score {
  Duration time;
  int moves;
  Score({
    required this.time,
    required this.moves,
  });

  int get points {
    int points = moves + time.inSeconds;
    return points;
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time.inSeconds,
      'moves': moves,
    };
  }

  String toJson() => json.encode(toMap());

  factory Score.fromJson(String source) => Score.fromMap(json.decode(source));

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      time: Duration(seconds: map['time']),
      moves: map['moves']?.toInt() ?? 0,
    );
  }
}
