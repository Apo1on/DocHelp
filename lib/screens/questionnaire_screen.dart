import 'package:flutter/material.dart';
import '../models/question.dart';
import 'userdata_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  final List<Question> questions;

  const QuestionnaireScreen({Key? key, required this.questions}) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int _currentQuestionIndex = 0;
  List<String?> _answers = []; // List to store user's answers
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    // Initialize the answers list with null values
    _answers = List<String?>.filled(widget.questions.length, null);
  }

  void _nextQuestion(BuildContext context) {
    if (_selectedAnswer == null) {
      // Show a message if no answer is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, выберите ответ.'),
          duration: Duration(milliseconds: 500), // Adjust the duration as needed
        ),
      );
      return; // Do not proceed if no answer is selected
    }
    setState(() {
      _selectedAnswer = null;

      if (_currentQuestionIndex < widget.questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Navigate to UserDataScreen when all questions are answered
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDataScreen(answers: _answers),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion = widget.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Опросник'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentQuestion.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (currentQuestion.gifUrl != null)
              Image.network(
                currentQuestion.gifUrl!,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 20),
            ...currentQuestion.answers.map((answer) =>
                RadioListTile<String>(
                  title: Text(answer),
                  value: answer,
                  groupValue: _selectedAnswer,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAnswer = value;
                      _answers[_currentQuestionIndex] = value; // Store the answer here
                    });
                  },
                )
            ).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _nextQuestion(context),
              child: Text(
                  _currentQuestionIndex < widget.questions.length - 1
                      ? 'Следующий вопрос'
                      : 'Завершить'
              ),
            ),
          ],
        ),
      ),
    );
  }
}