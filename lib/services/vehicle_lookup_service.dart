import '../models/vehicle.dart';

class VehicleLookupService {
  /// VIN lookup.
  ///
  /// This is ready to be connected to a real VIN-data provider later.
  /// For now it validates the VIN and returns a Vehicle object containing
  /// the VIN so the rest of the app can continue working.
  Future<Vehicle> lookupByVin(String vin) async {
    final cleanVin = vin.trim().toUpperCase();

    if (cleanVin.length != 17) {
      throw Exception('VIN must be 17 characters.');
    }

    return Vehicle(
      vin: cleanVin,
      registration: '',
      state: '',
      year: '',
      make: '',
      model: '',
      variant: '',
      vehicleType: 'Car',
    );
  }

  /// Australian registration / number plate lookup.
  ///
  /// A real registration lookup requires an authorised data provider/API.
  /// This method is structured so we can connect that provider later.
  Future<Vehicle> lookupByRegistration({
    required String registration,
    required String state,
  }) async {
    final cleanRegistration =
        registration.trim().toUpperCase().replaceAll(' ', '');

    if (cleanRegistration.isEmpty) {
      throw Exception('Enter a registration number.');
    }

    if (state.trim().isEmpty) {
      throw Exception('Select a state or territory.');
    }

    return Vehicle(
      vin: '',
      registration: cleanRegistration,
      state: state.toUpperCase(),
      year: '',
      make: '',
      model: '',
      variant: '',
      vehicleType: 'Car',
    );
  }

  /// Manual vehicle entry for cars, motorcycles, trucks and boats.
  Future<Vehicle> createManualVehicle({
    required String vehicleType,
    required String year,
    required String make,
    required String model,
    String variant = '',
  }) async {
    if (year.trim().isEmpty ||
        make.trim().isEmpty ||
        model.trim().isEmpty) {
      throw Exception('Year, make and model are required.');
    }

    return Vehicle(
      vin: '',
      registration: '',
      state: '',
      year: year.trim(),
      make: make.trim(),
      model: model.trim(),
      variant: variant.trim(),
      vehicleType: vehicleType.trim(),
    );
  }

  static const List<String> australianStates = [
    'QLD',
    'NSW',
    'VIC',
    'SA',
    'WA',
    'TAS',
    'NT',
    'ACT',
  ];

  static const List<String> vehicleTypes = [
    'Car',
    'Motorcycle',
    'Truck',
    'Boat',
  ];
}
