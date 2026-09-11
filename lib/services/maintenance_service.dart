class MaintenanceItem {
  final String category;
  final String title;
  final String searchTerm;
  final String note;

  const MaintenanceItem({
    required this.category,
    required this.title,
    required this.searchTerm,
    this.note = '',
  });
}

class MaintenanceService {
  static const List<MaintenanceItem> allItems = [
    MaintenanceItem(
      category: 'Engine',
      title: 'Engine oil',
      searchTerm: 'engine oil',
      note: 'Check viscosity and manufacturer specification.',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Oil filter',
      searchTerm: 'oil filter',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Air filter',
      searchTerm: 'air filter',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Fuel filter',
      searchTerm: 'fuel filter',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Cabin / pollen filter',
      searchTerm: 'cabin pollen filter',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Spark plugs',
      searchTerm: 'spark plugs',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Glow plugs',
      searchTerm: 'glow plugs',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'PCV valve',
      searchTerm: 'PCV valve',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Drive / serpentine belt',
      searchTerm: 'serpentine drive belt',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Timing belt kit',
      searchTerm: 'timing belt kit',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Timing chain kit',
      searchTerm: 'timing chain kit',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Tensioner / idler pulleys',
      searchTerm: 'belt tensioner idler pulley',
    ),
    MaintenanceItem(
      category: 'Engine',
      title: 'Full service kit',
      searchTerm: 'full service kit filters plugs oil',
    ),

    MaintenanceItem(
      category: 'Cooling',
      title: 'Coolant',
      searchTerm: 'coolant antifreeze',
      note: 'Use the correct coolant type/specification.',
    ),
    MaintenanceItem(
      category: 'Cooling',
      title: 'Radiator',
      searchTerm: 'radiator',
    ),
    MaintenanceItem(
      category: 'Cooling',
      title: 'Radiator cap',
      searchTerm: 'radiator cap',
    ),
    MaintenanceItem(
      category: 'Cooling',
      title: 'Radiator hoses',
      searchTerm: 'radiator hose',
    ),
    MaintenanceItem(
      category: 'Cooling',
      title: 'Heater hoses',
      searchTerm: 'heater hose',
    ),
    MaintenanceItem(
      category: 'Cooling',
      title: 'Thermostat',
      searchTerm: 'thermostat',
    ),
    MaintenanceItem(
      category: 'Cooling',
      title: 'Water pump',
      searchTerm: 'water pump',
    ),

    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'Automatic transmission fluid',
      searchTerm: 'automatic transmission fluid ATF',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'Manual gearbox oil',
      searchTerm: 'manual gearbox oil',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'CVT fluid',
      searchTerm: 'CVT fluid',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'Differential oil',
      searchTerm: 'differential gear oil',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'Transfer case oil',
      searchTerm: 'transfer case oil',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'Clutch kit',
      searchTerm: 'clutch kit',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'CV joints',
      searchTerm: 'CV joint',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'CV boots',
      searchTerm: 'CV boot kit',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'Universal joints',
      searchTerm: 'universal joint U joint',
    ),
    MaintenanceItem(
      category: 'Transmission & Driveline',
      title: 'Wheel bearings',
      searchTerm: 'wheel bearing kit',
    ),

    MaintenanceItem(
      category: 'Brakes',
      title: 'Brake fluid',
      searchTerm: 'brake fluid',
    ),
    MaintenanceItem(
      category: 'Brakes',
      title: 'Front brake pads',
      searchTerm: 'front brake pads',
    ),
    MaintenanceItem(
      category: 'Brakes',
      title: 'Rear brake pads',
      searchTerm: 'rear brake pads',
    ),
    MaintenanceItem(
      category: 'Brakes',
      title: 'Brake rotors',
      searchTerm: 'brake rotors discs',
    ),
    MaintenanceItem(
      category: 'Brakes',
      title: 'Brake shoes',
      searchTerm: 'brake shoes',
    ),
    MaintenanceItem(
      category: 'Brakes',
      title: 'Brake master cylinder',
      searchTerm: 'brake master cylinder',
    ),

    MaintenanceItem(
      category: 'Steering & Suspension',
      title: 'Power steering fluid',
      searchTerm: 'power steering fluid',
    ),
    MaintenanceItem(
      category: 'Steering & Suspension',
      title: 'Shock absorbers / struts',
      searchTerm: 'shock absorber strut',
    ),
    MaintenanceItem(
      category: 'Steering & Suspension',
      title: 'Suspension bushes',
      searchTerm: 'suspension bush kit',
    ),
    MaintenanceItem(
      category: 'Steering & Suspension',
      title: 'Ball joints',
      searchTerm: 'ball joint',
    ),
    MaintenanceItem(
      category: 'Steering & Suspension',
      title: 'Tie rod ends',
      searchTerm: 'tie rod end',
    ),
    MaintenanceItem(
      category: 'Steering & Suspension',
      title: 'Sway bar links',
      searchTerm: 'sway bar link',
    ),

    MaintenanceItem(
      category: 'Electrical',
      title: 'Battery',
      searchTerm: 'battery',
    ),
    MaintenanceItem(
      category: 'Electrical',
      title: 'Alternator',
      searchTerm: 'alternator',
    ),
    MaintenanceItem(
      category: 'Electrical',
      title: 'Starter motor',
      searchTerm: 'starter motor',
    ),
    MaintenanceItem(
      category: 'Electrical',
      title: 'Headlight globes',
      searchTerm: 'headlight globe bulb',
    ),
    MaintenanceItem(
      category: 'Electrical',
      title: 'Fuses',
      searchTerm: 'automotive fuse kit',
    ),
    MaintenanceItem(
      category: 'Electrical',
      title: 'Wiper blades',
      searchTerm: 'wiper blades',
    ),

    MaintenanceItem(
      category: 'Diesel / Emissions',
      title: 'AdBlue / DEF',
      searchTerm: 'AdBlue DEF',
      note: 'Only for vehicles that use SCR/AdBlue.',
    ),
    MaintenanceItem(
      category: 'Diesel / Emissions',
      title: 'DPF cleaner',
      searchTerm: 'DPF cleaner',
    ),
    MaintenanceItem(
      category: 'Diesel / Emissions',
      title: 'EGR cleaner',
      searchTerm: 'EGR cleaner',
    ),
    MaintenanceItem(
      category: 'Diesel / Emissions',
      title: 'Diesel injector cleaner',
      searchTerm: 'diesel injector cleaner',
    ),

    MaintenanceItem(
      category: 'Motorcycle',
      title: 'Motorcycle engine oil',
      searchTerm: 'motorcycle engine oil',
    ),
    MaintenanceItem(
      category: 'Motorcycle',
      title: 'Motorcycle oil filter',
      searchTerm: 'motorcycle oil filter',
    ),
    MaintenanceItem(
      category: 'Motorcycle',
      title: 'Motorcycle air filter',
      searchTerm: 'motorcycle air filter',
    ),
    MaintenanceItem(
      category: 'Motorcycle',
      title: 'Chain and sprocket kit',
      searchTerm: 'motorcycle chain sprocket kit',
    ),
    MaintenanceItem(
      category: 'Motorcycle',
      title: 'Chain lube',
      searchTerm: 'motorcycle chain lube',
    ),
    MaintenanceItem(
      category: 'Motorcycle',
      title: 'Fork oil',
      searchTerm: 'motorcycle fork oil',
    ),

    MaintenanceItem(
      category: 'Marine',
      title: 'Marine engine oil',
      searchTerm: 'marine engine oil',
    ),
    MaintenanceItem(
      category: 'Marine',
      title: 'Marine oil filter',
      searchTerm: 'marine oil filter',
    ),
    MaintenanceItem(
      category: 'Marine',
      title: 'Marine fuel filter',
      searchTerm: 'marine fuel filter',
    ),
    MaintenanceItem(
      category: 'Marine',
      title: 'Impeller kit',
      searchTerm: 'marine water pump impeller kit',
    ),
    MaintenanceItem(
      category: 'Marine',
      title: 'Gearcase oil',
      searchTerm: 'outboard gearcase oil',
    ),
    MaintenanceItem(
      category: 'Marine',
      title: 'Marine grease',
      searchTerm: 'marine grease',
    ),

    MaintenanceItem(
      category: 'General',
      title: 'Grease',
      searchTerm: 'automotive grease',
    ),
    MaintenanceItem(
      category: 'General',
      title: 'Brake cleaner',
      searchTerm: 'brake cleaner',
    ),
    MaintenanceItem(
      category: 'General',
      title: 'Contact cleaner',
      searchTerm: 'electrical contact cleaner',
    ),
    MaintenanceItem(
      category: 'General',
      title: 'Service kit',
      searchTerm: 'service kit',
    ),
  ];
}
