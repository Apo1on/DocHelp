import 'package:flutter/material.dart';
import 'package:dochelp/models/question.dart';
import 'package:dochelp/screens/questionnaire_screen.dart';
import 'package:dochelp/screens/test_history_screen.dart'; 

void main() {
  runApp(const DocHelpApp());
}

class DocHelpApp extends StatelessWidget {
  const DocHelpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocHelp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DocHelp Опросник'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Question> questions = [
    Question(
      text: 'Вопрос 1: Оцените состояние струи при мочеиспускании?',
      answers: ['1', '2', '3', '4', '5'],
      gifUrl: '-',
    ),
    Question(
      text: 'Вопрос 2: Сколько мочеиспусканий у вас днём?',
      answers: ['0', '1', '2','3','4','5', '6+'],
      gifUrl: '-',
    ),
    Question(
      text: 'Вопрос 3: Сколько мочеиспусканий у вас ночью?',
      answers: ['0', '1', '2','3','4','5', '6+'],
      gifUrl: '-',
    ),
    Question(
      text: 'Вопрос 4: Оцените ваше качество жизни на фоне имеющихся проблем?',
      answers: ['прекрасно(0)', 'хорошо(1)', 'средне(2)', 'некоторый дискофорт(3)', 'плохо(4)', 'ужасно(5)'],
      gifUrl: '-', 
    ),
    Question(
      text: 'Вопрос 5: Как хорошо вам понятны вопросы в анкете?',
      answers: ['Все понял', 'не очень понял', 'не понял'],
      gifUrl: '-',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Добро пожаловать в опросник DocHelp!',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionnaireScreen(questions: questions),
                  ),
                );
              },
              child: const Text('Начать опрос'),
            ),
            const SizedBox(height: 20), // Add some spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TestHistoryScreen(),
                  ),
                );
              },
              child: const Text('История тестов'),
            ),
          ],
        ),
      ),
    );
  }
}