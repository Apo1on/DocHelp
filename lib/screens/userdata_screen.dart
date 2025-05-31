import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'results_screen.dart';
import '../services/data_storage_service.dart';

class UserDataScreen extends StatefulWidget {
  final List<String?> answers;

  const UserDataScreen({Key? key, required this.answers}) : super(key: key);

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  final _dataStorageService = DataStorageService();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваши данные'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[а-яА-ЯёЁa-zA-Z\s-]'), // русские/английские буквы, пробелы и дефисы
                  ),
                  LengthLimitingTextInputFormatter(50), // макс длина 50
                ],
                decoration: const InputDecoration(
                  labelText: 'Ваше имя',
                  hintText: 'Введите ваше имя',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ваше имя';
                  }
                  if (!RegExp(r'^[а-яА-ЯёЁa-zA-Z\s-]+$').hasMatch(value)) {
                    return 'Имя может содержать только буквы и пробелы';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userName = value!.trim();
                },
                autofocus: true, // Автофокус на поле
                textInputAction: TextInputAction.done, // Кнопка "Готово" на клавиатуре
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Показать результаты'),

                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await _dataStorageService.saveTestResult(_userName, widget.answers);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsScreen(
                          userName: _userName,
                          answers: widget.answers,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), 
              ),
          )],
          ),
        ),
      ),
    );
  }
}