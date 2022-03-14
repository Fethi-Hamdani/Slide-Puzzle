import 'package:slidepuzzle/Core/Models/slide.dart';

class Move {
  List<Slide> slides;
  Move({
    required this.slides,
  });
  factory Move.clone(Move source) {
    return Move(
      slides: source.slides.map((e) => Slide.clone(e)).toList(),
    );
  }
}
