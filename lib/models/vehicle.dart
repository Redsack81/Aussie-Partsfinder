enum VehicleType {
  car,
  motorcycle,
  truck,
  boat,
}

class Vehicle {
  final VehicleType type;
  final String make;
  final String model;
  final String year;
  final String? vin;
  final String? registration;
  final String? state;

  const Vehicle({
    required this.type,
    required this.make,
    required this.model,
    required this.year,
    this.vin,
    this.registration,
    this.state,
  });

  String get displayName {
    return '$year $make $model'.trim();
  }

  String get searchQuery {
    return '$year $make $model'.trim();
  }

  Vehicle copyWith({
    VehicleType? type,
    String? make,
    String? model,
    String? year,
    String? vin,
    String? registration,
    String? state,
  }) {
    return Vehicle(
      type: type ?? this.type,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      vin: vin ?? this.vin,
      registration: registration ?? this.registration,
      state: state ?? this.state,
    );
  }
}
