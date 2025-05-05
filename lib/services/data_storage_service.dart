import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorageService {
  static const String _historyKey = 'test_history';

  Future<void> saveTestResult(String userName, List<String?> answers) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> history = await getTestHistory();

    final newResult = {
      'userName': userName,
      'answers': answers,
      'timestamp': DateTime.now().toIso8601String(),
    };

    history.add(newResult);
    await prefs.setString(_historyKey, jsonEncode(history));
  }

  Future<List<Map<String, dynamic>>> getTestHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyString = prefs.getString(_historyKey);

    if (historyString == null) {
      return [];
    }

    try {
      final List<dynamic> decodedList = jsonDecode(historyString);
      return decodedList.cast<Map<String, dynamic>>().toList();
    } catch (e) {
      print('Error decoding history: $e');
      return [];
    }
  }
}