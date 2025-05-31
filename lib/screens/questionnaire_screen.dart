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
  List<String?> _answers = [];
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _answers = List<String?>.filled(widget.questions.length, null);
  }

  void _nextQuestion(BuildContext context) {
    if (_selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, выберите ответ.'),
          duration: Duration(milliseconds: 500), 
        ),
      );
      return; 
    }
    setState(() {
      _selectedAnswer = null;

      if (_currentQuestionIndex < widget.questions.length - 1) {
        _currentQuestionIndex++;
      } else {
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / widget.questions.length,
                  minHeight: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                ),
                SizedBox(height: 12),
                Text(
                  'Вопрос ${_currentQuestionIndex + 1} из ${widget.questions.length}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentQuestion.text,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        if (currentQuestion.gifAssetPath != null) ...[
                          SizedBox(height: 16),
                          Center(
                            child: Image.asset(
                            currentQuestion.gifAssetPath!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(); 
                            },
                          ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ...currentQuestion.answers.map((answer) => Card(
                  margin: EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: _selectedAnswer == answer 
                      ? Color(0xFF2196F3).withOpacity(0.1)
                      : Colors.white,
                  child: RadioListTile<String>(
                    title: Text(
                      answer,
                      style: TextStyle(
                        color: _selectedAnswer == answer
                            ? Color(0xFF1976D2)
                            : Colors.black87,
                      ),
                    ),
                    value: answer,
                    groupValue: _selectedAnswer,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedAnswer = value;
                        _answers[_currentQuestionIndex] = value;
                      });
                    },
                    activeColor: Color(0xFF2196F3),
                  ),
                )).toList(),
                SizedBox(height: 20), 
                ElevatedButton(
                  onPressed: () => _nextQuestion(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    _currentQuestionIndex < widget.questions.length - 1
                        ? 'Следующий вопрос'
                        : 'Завершить',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}