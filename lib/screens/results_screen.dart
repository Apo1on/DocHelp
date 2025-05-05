import 'package:flutter/material.dart';
import '../main.dart'; 

class ResultsScreen extends StatelessWidget {
  final String userName;
  final List<String?> answers;

  const ResultsScreen({Key? key, required this.userName, required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты опроса'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Спасибо, $userName!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ваши ответы:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: answers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Вопрос ${index + 1}: ${answers[index] ?? "Нет ответа"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: 'DocHelp Опросник')),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Вернуться на главную'),
              ),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}