class FieldModel {
  final String id;
  final String name;
  final String location;
  final double sizeInAcres;
  final String cropType;
  final DateTime plantingTime;

  FieldModel({
    required this.id,
    required this.name,
    required this.location,
    required this.sizeInAcres,
    required this.cropType,
    required this.plantingTime,
  });

  FieldModel copyWith({
    String? id,
    String? name,
    String? location,
    double? sizeInAcres,
    String? cropType,
    DateTime? plantingTime,
  }) {
    return FieldModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      sizeInAcres: sizeInAcres ?? this.sizeInAcres,
      cropType: cropType ?? this.cropType,
      plantingTime: plantingTime ?? this.plantingTime,
    );
  }
}
