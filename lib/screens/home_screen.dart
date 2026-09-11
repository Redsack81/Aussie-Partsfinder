import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import 'maintenance_screen.dart';
import 'search_results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VehicleType _type = VehicleType.car;

  final _year = TextEditingController();
  final _make = TextEditingController();
  final _model = TextEditingController();
  final _series = TextEditingController();
  final _engine = TextEditingController();
  final _vin = TextEditingController();
  final _rego = TextEditingController();
  final _part = TextEditingController();

  Vehicle get _vehicle => Vehicle(
        type: _type,
        year: _year.text.trim(),
        make: _make.text.trim(),
        model: _model.text.trim(),
        series: _series.text.trim(),
        engine: _engine.text.trim(),
        vin: _vin.text.trim(),
        registration: _rego.text.trim(),
      );

  void _search() {
    final query = _vehicle.buildQuery(_part.text);

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a vehicle or part to search.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(
          query: query,
          vehicleType: _type.name,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _year.dispose();
    _make.dispose();
    _model.dispose();
    _series.dispose();
    _engine.dispose();
    _vin.dispose();
    _rego.dispose();
    _part.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aussie PartsFinder'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Find new & used parts across Australia',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),

          const Text(
            'Cars • Motorcycles • Trucks • Boats',
          ),

          const SizedBox(height: 20),

          SegmentedButton<VehicleType>(
            segments: const [
              ButtonSegment(
                value: VehicleType.car,
                label: Text('Car'),
                icon: Icon(Icons.directions_car),
              ),
              ButtonSegment(
                value: VehicleType.motorcycle,
                label: Text('Bike'),
                icon: Icon(Icons.two_wheeler),
              ),
              ButtonSegment(
                value: VehicleType.truck,
                label: Text('Truck'),
                icon: Icon(Icons.local_shipping),
              ),
              ButtonSegment(
                value: VehicleType.boat,
                label: Text('Boat'),
                icon: Icon(Icons.directions_boat),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (value) {
              setState(() {
                _type = value.first;
              });
            },
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _field(
                  _year,
                  'Year',
                  TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _field(
                  _make,
                  'Make',
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _field(
                  _model,
                  'Model',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _field(
                  _series,
                  'Series / variant',
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          _field(
            _engine,
            'Engine / capacity',
          ),

          const SizedBox(height: 10),

          _field(
            _part,
            'Part, part number or description',
          ),

          const SizedBox(height: 10),

          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Text(
              'VIN / registration search',
            ),
            children: [
              _field(
                _vin,
                'VIN',
              ),

              const SizedBox(height: 10),

              _field(
                _rego,
                'Registration / number plate',
              ),

              const SizedBox(height: 8),

              const Text(
                'VIN and registration lookup can be connected '
                'to an authorised vehicle-data provider.',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 16),

          FilledButton.icon(
            onPressed: _search,
            icon: const Icon(Icons.search),
            label: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Text(
                'SEARCH PARTS',
              ),
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MaintenanceScreen(
                    vehicle: _vehicle,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.build_circle_outlined,
            ),
            label: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Text(
                'MAINTENANCE & SERVICE PARTS',
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Card(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'Search new and used parts from Australian '
                'marketplaces, retailers and wreckers.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, [
    TextInputType? keyboardType,
  ]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
