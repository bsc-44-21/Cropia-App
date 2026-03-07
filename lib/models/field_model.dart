import 'field_activity.dart';

class FieldModel {
  final String id;
  final String name;
  final String location;
  final double sizeInAcres;
  final String cropType;
  final DateTime plantingTime;
  final List<FieldActivity> activities;

  FieldModel({
    required this.id,
    required this.name,
    required this.location,
    required this.sizeInAcres,
    required this.cropType,
    required this.plantingTime,
    required this.activities,
  });

  FieldModel copyWith({
    String? id,
    String? name,
    String? location,
    double? sizeInAcres,
    String? cropType,
    DateTime? plantingTime,
    List<FieldActivity>? activities,
  }) {
    return FieldModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      sizeInAcres: sizeInAcres ?? this.sizeInAcres,
      cropType: cropType ?? this.cropType,
      plantingTime: plantingTime ?? this.plantingTime,
      activities: activities ?? this.activities,
    );
  }
}
