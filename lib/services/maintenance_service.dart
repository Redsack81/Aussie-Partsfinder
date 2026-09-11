class MaintenanceItem {
  final String name;
  final String category;
  final String description;
  final String searchTerm;
  final String icon;

  const MaintenanceItem({
    required this.name,
    required this.category,
    required this.description,
    required this.searchTerm,
    required this.icon,
  });
}

class MaintenanceService {
  /// Creates maintenance/servicing suggestions for the selected vehicle.
  ///
  /// Later we can connect this to vehicle databases and supplier APIs so
  /// the app can return exact oil grades, capacities and part numbers.
  static List<MaintenanceItem> getMaintenanceItems({
    required String make,
    required String model,
    required String year,
    String? engine,
  }) {
    final vehicle = [
      year,
      make,
      model,
      if (engine != null && engine.trim().isNotEmpty) engine.trim(),
    ].join(' ');

    return [
      MaintenanceItem(
        name: 'Engine Oil',
        category: 'Fluids',
        description: 'Find suitable engine oil for $vehicle',
        searchTerm: '$vehicle recommended engine oil',
        icon: 'oil',
      ),
      MaintenanceItem(
        name: 'Oil Filter',
        category: 'Filters',
        description: 'Find replacement oil filters for $vehicle',
        searchTerm: '$vehicle oil filter',
        icon: 'filter',
      ),
      MaintenanceItem(
        name: 'Air Filter',
        category: 'Filters',
        description: 'Find replacement engine air filters for $vehicle',
        searchTerm: '$vehicle air filter',
        icon: 'air',
      ),
      MaintenanceItem(
        name: 'Fuel Filter',
        category: 'Filters',
        description: 'Find replacement fuel filters for $vehicle',
        searchTerm: '$vehicle fuel filter',
        icon: 'fuel',
      ),
      MaintenanceItem(
        name: 'Coolant',
        category: 'Fluids',
        description: 'Find suitable coolant for $vehicle',
        searchTerm: '$vehicle recommended coolant',
        icon: 'coolant',
      ),
      MaintenanceItem(
        name: 'Brake Fluid',
        category: 'Fluids',
        description: 'Find suitable brake fluid for $vehicle',
        searchTerm: '$vehicle recommended brake fluid',
        icon: 'brakes',
      ),
      MaintenanceItem(
        name: 'Transmission Fluid',
        category: 'Fluids',
        description: 'Find suitable transmission oil/fluid for $vehicle',
        searchTerm: '$vehicle recommended transmission fluid',
        icon: 'transmission',
      ),
      MaintenanceItem(
        name: 'Spark Plugs',
        category: 'Ignition',
        description: 'Find replacement spark plugs for $vehicle',
        searchTerm: '$vehicle spark plugs',
        icon: 'spark',
      ),
      MaintenanceItem(
        name: 'Cabin Filter',
        category: 'Filters',
        description: 'Find replacement cabin/pollen filters for $vehicle',
        searchTerm: '$vehicle cabin filter',
        icon: 'cabin',
      ),
      MaintenanceItem(
        name: 'Drive Belts',
        category: 'Engine',
        description: 'Find replacement belts for $vehicle',
        searchTerm: '$vehicle drive belt serpentine belt',
        icon: 'belt',
      ),
      MaintenanceItem(
        name: 'Brake Pads',
        category: 'Brakes',
        description: 'Find replacement brake pads for $vehicle',
        searchTerm: '$vehicle brake pads',
        icon: 'brakes',
      ),
      MaintenanceItem(
        name: 'Wiper Blades',
        category: 'General',
        description: 'Find replacement wiper blades for $vehicle',
        searchTerm: '$vehicle wiper blades',
        icon: 'wipers',
      ),
    ];
  }

  /// Creates the search phrase that can be sent to our parts search service.
  static String buildSearchQuery({
    required MaintenanceItem item,
    required String make,
    required String model,
    required String year,
    String? engine,
  }) {
    return [
      year,
      make,
      model,
      if (engine != null && engine.trim().isNotEmpty) engine.trim(),
      item.name,
    ].join(' ');
  }
}
