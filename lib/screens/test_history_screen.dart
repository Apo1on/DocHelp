import 'package:flutter/material.dart';
import '../services/data_storage_service.dart';
import 'package:intl/intl.dart';  // Add this line

class TestHistoryScreen extends StatefulWidget {
  const TestHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TestHistoryScreen> createState() => _TestHistoryScreenState();
}

class _TestHistoryScreenState extends State<TestHistoryScreen> {
  final _dataStorageService = DataStorageService();
  List<Map<String, dynamic>> _testHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await _dataStorageService.getTestHistory();
    setState(() {
      _testHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История тестов'),
      ),
      body: _testHistory.isEmpty
          ? const Center(child: Text('История тестов пуста'))
          : ListView.builder(
              itemCount: _testHistory.length,
              itemBuilder: (context, index) {
                final result = _testHistory[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Имя: ${result['userName']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          'Дата: ${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(result['timestamp']))}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        
                        const SizedBox(height: 8.0),
                        const Text('Ответы:', style: TextStyle(fontWeight: FontWeight.bold)),
                        for (int i = 0; i < (result['answers'] as List<dynamic>).length; i++)
                          Text('Вопрос ${i + 1}: ${result['answers'][i] ?? "Нет ответа"}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}