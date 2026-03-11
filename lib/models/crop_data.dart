class CropData {
  final String cropType;
  final int durationDays;
  final double yieldPerAcre;
  final String yieldUnit;
  final double pricePerUnit;

  CropData({
    required this.cropType,
    required this.durationDays,
    required this.yieldPerAcre,
    required this.yieldUnit,
    required this.pricePerUnit,
  });

  static List<CropData> defaults = [
    CropData(
      cropType: 'Maize',
      durationDays: 90,
      yieldPerAcre: 2000,
      yieldUnit: 'KG',
      pricePerUnit: 4000.0,
    ),
    CropData(
      cropType: 'Tomato',
      durationDays: 90,
      yieldPerAcre: 200,
      yieldUnit: 'Crates',
      pricePerUnit: 15000.0,
    ),
  ];

  static CropData getFor(String type) {
    return defaults.firstWhere(
      (c) => c.cropType.toLowerCase() == type.toLowerCase(),
      orElse: () => defaults.first,
    );
  }
}
