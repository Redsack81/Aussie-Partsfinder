enum VehicleType {
  car,
  motorcycle,
  truck,
  boat,
}

class Vehicle {
  final VehicleType type;
  final String year;
  final String make;
  final String model;
  final String series;
  final String engine;
  final String vin;
  final String registration;

  const Vehicle({
    required this.type,
    this.year = '',
    this.make = '',
    this.model = '',
    this.series = '',
    this.engine = '',
    this.vin = '',
    this.registration = '',
  });

  String get displayName {
    return [
      year,
      make,
      model,
      series,
      engine,
    ].where((value) => value.trim().isNotEmpty).join(' ');
  }

  String buildQuery(String part) {
    return [
      year,
      make,
      model,
      series,
      engine,
      part,
    ].where((value) => value.trim().isNotEmpty).join(' ');
  }

  Vehicle copyWith({
    VehicleType? type,
    String? year,
    String? make,
    String? model,
    String? series,
    String? engine,
    String? vin,
    String? registration,
  }) {
    return Vehicle(
      type: type ?? this.type,
      year: year ?? this.year,
      make: make ?? this.make,
      model: model ?? this.model,
      series: series ?? this.series,
      engine: engine ?? this.engine,
      vin: vin ?? this.vin,
      registration: registration ?? this.registration,
    );
  }
}
