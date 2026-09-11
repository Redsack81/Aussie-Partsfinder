import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../services/maintenance_service.dart';
import 'search_results_screen.dart';

class MaintenanceScreen extends StatefulWidget {
  final Vehicle vehicle;

  const MaintenanceScreen({
    super.key,
    required this.vehicle,
  });

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final items = MaintenanceService.allItems.where((item) {
      if (_filter.trim().isEmpty) return true;

      final filter = _filter.toLowerCase();

      return item.title.toLowerCase().contains(filter) ||
          item.category.toLowerCase().contains(filter) ||
          item.searchTerm.toLowerCase().contains(filter);
    }).toList();

    final grouped = <String, List<dynamic>>{};

    for (final item in items) {
      grouped.putIfAbsent(
        item.category,
        () => [],
      );

      grouped[item.category]!.add(item);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Maintenance & Service',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          if (widget.vehicle.displayName.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Vehicle: ${widget.vehicle.displayName}',
                ),
              ),
            ),

          const SizedBox(height: 8),

          TextField(
            onChanged: (value) {
              setState(() {
                _filter = value;
              });
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Search maintenance items',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          ...grouped.entries.map(
            (entry) {
              return ExpansionTile(
                initiallyExpanded: _filter.isNotEmpty,
                title: Text(
                  '${entry.key} (${entry.value.length})',
                ),
                children: entry.value.map(
                  (dynamic item) {
                    return ListTile(
                      title: Text(
                        item.title,
                      ),
                      subtitle: item.note.isEmpty
                          ? null
                          : Text(
                              item.note,
                            ),
                      trailing: const Icon(
                        Icons.chevron_right,
                      ),
                      onTap: () {
                        final query = widget.vehicle.buildQuery(
                          item.searchTerm,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SearchResultsScreen(
                              query: query,
                              vehicleType:
                                  widget.vehicle.type.name,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              );
            },
          ),

          const SizedBox(height: 14),

          const Text(
            'Always confirm the correct oil grade, fluid specification, '
            'capacity, service interval and exact part fitment for your '
            'vehicle before purchasing or using a product.',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
