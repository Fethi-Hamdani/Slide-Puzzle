class Slide {
  int startIndex;
  int endIndex;
  Slide({
    required this.startIndex,
    required this.endIndex,
  });
  factory Slide.clone(Slide source) {
    return Slide(endIndex: source.endIndex, startIndex: source.startIndex);
  }
  @override
  String toString() => 'from: $startIndex to: $endIndex)';
}
