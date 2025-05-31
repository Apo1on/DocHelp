class Question {
  final String text;
  final List<String> answers;
  final String? gifAssetPath; 
  Question({
    required this.text,
    required this.answers,
    this.gifAssetPath, 
  });
}