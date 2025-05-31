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
      home: MyHomePage(title: 'DocHelp Опросник'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF2196F3),       // Основной синий
          secondary: Color(0xFF4CAF50),      // Зелёный акцент
        ),
        scaffoldBackgroundColor: Color(0xFFE3F2FD), // Светло-голубой фон
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF2196F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF1976D2), // Более тёмный синий для AppBar
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
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
      gifAssetPath: 'assets/gif/PlaceHolder1.gif',
    ),
    Question(
      text: 'Вопрос 2: Сколько мочеиспусканий у вас днём?',
      answers: ['0', '1', '2','3','4','5', '6+'],
      gifAssetPath: 'assets/gif/PlaceHolder2.gif',
    ),
    Question(
      text: 'Вопрос 3: Сколько мочеиспусканий у вас ночью?',
      answers: ['0', '1', '2','3','4','5', '6+'],
      gifAssetPath: 'assets/gif/PlaceHolder3.gif',
    ),
    Question(
      text: 'Вопрос 4: Оцените ваше качество жизни на фоне имеющихся проблем?',
      answers: ['Счастлив(0)', 'Прекрасно(1)', 'Хорошо(2)', 'Нормально(3)', 'Не очень(4)', 'Плохо(5)', 'Ужасно(6)'],
      gifAssetPath: 'assets/gif/PlaceHolder4.gif', 
    ),
    Question(
      text: 'Вопрос 5: Как хорошо вам понятны вопросы в анкете?',
      answers: ['Все понял', 'не очень понял', 'не понял'],
      gifAssetPath: '-',
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
              style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24, 
                      vertical: 16,
                    ),
                  ),
              child: const Text('Начать опрос'),
              
            ),
            const SizedBox(height: 20, width: 150),

            ElevatedButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TestHistoryScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 24, 
                  vertical: 16,
                ),
              ),
              child: const Text('История тестов'),
              
            ),
          ],
        ),
      ),
    );
  }
}