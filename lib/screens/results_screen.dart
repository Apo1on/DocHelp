import 'package:flutter/material.dart';
import '../main.dart'; 

class ResultsScreen extends StatelessWidget {
  final String userName;
  final List<String?> answers;

  const ResultsScreen({Key? key, required this.userName, required this.answers}) : super(key: key);

  String _calculateProblemSeverity() {
    // Суммируем числовые значения первых 3 ответов
    int sum = 0;
    for (int i = 0; i < 3 && i < answers.length; i++) {
      try {
        
        sum += int.tryParse(answers[i] ?? '0') ?? 0;
        if( answers[i] == '6+')
        {
          sum += 6;
        }
      } catch (e) {
        // В случае ошибки просто игнорируем этот ответ
      }
    }

    // Определяем уровень проблемы
    if (sum < 7) return '${sum} пункт(ов), лёгкая степень (менее 6)';
    if (sum <= 13) return '${sum} пункт(ов), умеренная (от 7 до 13)';
    return '${sum} пункт(ов), тяжёлая (14+)';
  }

  @override
  Widget build(BuildContext context) {
    final problemSeverity = _calculateProblemSeverity();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты опроса'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Спасибо, $userName!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Ваши ответы сохранены',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Результат оценки проблемы:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(problemSeverity).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _getSeverityColor(problemSeverity),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          problemSeverity,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _getSeverityColor(problemSeverity),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: answers.length,
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Color(0xFF2196F3).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: Color(0xFF2196F3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Вопрос ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    answers[index] ?? "Нет ответа",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: 'DocHelp Опросник')),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50), // Зелёная кнопка
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text('Вернуться на главную'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    if (severity.contains('лёгкая')) return Colors.green;
    if (severity.contains('средняя')) return Colors.orange;
    return Colors.red;
  }
}