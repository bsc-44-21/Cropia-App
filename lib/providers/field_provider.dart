import 'package:flutter/material.dart';
import '../models/field_model.dart';
import '../models/field_activity.dart';
import '../services/notification_service.dart';

class FieldProvider with ChangeNotifier {
  final List<FieldModel> _fields = [];

  List<FieldModel> get fields => _fields;

  List<FieldActivity> _generateSchedule(String cropType, DateTime plantingTime) {
    List<FieldActivity> activities = [];
    if (cropType.toLowerCase() == 'maize') {
      activities.add(FieldActivity(title: 'Sowing Seeds', date: plantingTime));
      activities.add(FieldActivity(title: 'First Weeding', date: plantingTime.add(const Duration(days: 14))));
      activities.add(FieldActivity(title: 'Top Dressing Fertilizer', date: plantingTime.add(const Duration(days: 21))));
      activities.add(FieldActivity(title: 'Second Weeding', date: plantingTime.add(const Duration(days: 45))));
      activities.add(FieldActivity(title: 'Pest & Disease Inspection', date: plantingTime.add(const Duration(days: 60))));
      activities.add(FieldActivity(title: 'Harvesting', date: plantingTime.add(const Duration(days: 90))));
    } else if (cropType.toLowerCase() == 'tomato') {
      activities.add(FieldActivity(title: 'Transplanting', date: plantingTime));
      activities.add(FieldActivity(title: 'Staking & Tying', date: plantingTime.add(const Duration(days: 14))));
      activities.add(FieldActivity(title: 'First Pruning', date: plantingTime.add(const Duration(days: 21))));
      activities.add(FieldActivity(title: 'Apply NPK Fertilizer', date: plantingTime.add(const Duration(days: 30))));
      activities.add(FieldActivity(title: 'Pest & Fungicide App', date: plantingTime.add(const Duration(days: 60))));
      activities.add(FieldActivity(title: 'First Harvest', date: plantingTime.add(const Duration(days: 80))));
    }
    return activities;
  }

  void addField(FieldModel field) {
    if (field.activities.isEmpty) {
      field = field.copyWith(activities: _generateSchedule(field.cropType, field.plantingTime));
    }
    _fields.add(field);
    _scheduleNotificationsForField(field);
    notifyListeners();
  }

  void _scheduleNotificationsForField(FieldModel field) {
    for (int i = 0; i < field.activities.length; i++) {
      final activity = field.activities[i];
      if (!activity.isCompleted) {
        NotificationService.scheduleTaskNotification(
          id: (field.id + i.toString()).hashCode,
          fieldName: field.name,
          location: field.location,
          activity: activity,
        );
      }
    }
  }

  void _cancelNotificationsForField(FieldModel field) {
    for (int i = 0; i < field.activities.length; i++) {
      NotificationService.cancelNotification((field.id + i.toString()).hashCode);
    }
  }

  void updateField(FieldModel updatedField) {
    final index = _fields.indexWhere((field) => field.id == updatedField.id);
    if (index >= 0) {
      _cancelNotificationsForField(_fields[index]);
      
      _fields[index] = updatedField;
      // Recalculate activities if planting time or crop changed
      if (updatedField.activities.isEmpty || 
          updatedField.cropType != _fields[index].cropType || 
          updatedField.plantingTime != _fields[index].plantingTime) {
         _fields[index] = updatedField.copyWith(
           activities: _generateSchedule(updatedField.cropType, updatedField.plantingTime)
         );
      }
      _scheduleNotificationsForField(_fields[index]);
      notifyListeners();
    }
  }

  void deleteField(String id) {
    final field = _fields.firstWhere((f) => f.id == id);
    _cancelNotificationsForField(field);
    _fields.removeWhere((field) => field.id == id);
    notifyListeners();
  }

  void toggleActivityCompletion(String fieldId, int activityIndex) {
    final fieldIndex = _fields.indexWhere((field) => field.id == fieldId);
    if (fieldIndex >= 0) {
      final field = _fields[fieldIndex];
      final activities = List<FieldActivity>.from(field.activities);
      activities[activityIndex] = activities[activityIndex].copyWith(
        isCompleted: !activities[activityIndex].isCompleted
      );
      
      final updatedField = field.copyWith(activities: activities);
      _fields[fieldIndex] = updatedField;
      
      // Update notification status
      final notificationId = (fieldId + activityIndex.toString()).hashCode;
      if (activities[activityIndex].isCompleted) {
        NotificationService.cancelNotification(notificationId);
      } else {
        NotificationService.scheduleTaskNotification(
          id: notificationId,
          fieldName: field.name,
          location: field.location,
          activity: activities[activityIndex],
        );
      }
      
      notifyListeners();
    }
  }
}
