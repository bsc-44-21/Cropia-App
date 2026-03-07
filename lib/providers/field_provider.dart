import 'package:flutter/material.dart';
import '../models/field_model.dart';
import 'package:uuid/uuid.dart';

class FieldProvider with ChangeNotifier {
  final List<FieldModel> _fields = [];

  List<FieldModel> get fields => _fields;

  void addField(FieldModel field) {
    _fields.add(field);
    notifyListeners();
  }

  void updateField(FieldModel updatedField) {
    final index = _fields.indexWhere((field) => field.id == updatedField.id);
    if (index >= 0) {
      _fields[index] = updatedField;
      notifyListeners();
    }
  }

  void deleteField(String id) {
    _fields.removeWhere((field) => field.id == id);
    notifyListeners();
  }
}
