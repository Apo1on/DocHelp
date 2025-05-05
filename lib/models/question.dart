class Question {
  final String text;
  final List<String> answers;
  final String? gifUrl; 
  Question({
    required this.text,
    required this.answers,
    this.gifUrl, // gifUrl может быть null
  });
}