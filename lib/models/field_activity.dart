class FieldActivity {
  final String title;
  final DateTime date;
  bool isCompleted;

  FieldActivity({
    required this.title,
    required this.date,
    this.isCompleted = false,
  });

  FieldActivity copyWith({
    String? title,
    DateTime? date,
    bool? isCompleted,
  }) {
    return FieldActivity(
      title: title ?? this.title,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
