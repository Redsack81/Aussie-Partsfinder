import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PartFinderApp());

enum VehicleType { car, motorcycle, truck, boat }

class Marketplace {
  final String name;
  final String description;
  final String Function(String q) searchUrl;
  final VehicleType? vehicleType;
  final bool newParts;
  final bool usedParts;

  const Marketplace({
    required this.name,
    required this.description,
    required this.searchUrl,
    this.vehicleType,
    this.newParts = true,
    this.usedParts = true,
  });
}

String enc(String s) => Uri.encodeQueryComponent(s.trim());

final marketplaces = <Marketplace>[
  Marketplace(
    name: 'eBay Australia',
    description: 'New and used car, truck, motorcycle and accessory listings',
    searchUrl: (q) => 'https://www.ebay.com.au/sch/i.html?_nkw=${enc(q)}',
  ),
  Marketplace(
    name: 'Gumtree Australia',
    description: 'Private sellers, wreckers and local used parts',
    searchUrl: (q) => 'https://www.gumtree.com.au/s-${enc(q).replaceAll('+', '-')}/k0',
    usedParts: true,
    newParts: true,
  ),
  Marketplace(
    name: 'Facebook Marketplace',
    description: 'Local and private new/used listings',
    searchUrl: (q) => 'https://www.facebook.com/marketplace/search/?query=${enc(q)}',
    usedParts: true,
    newParts: true,
  ),
  Marketplace(
    name: 'PartsOnline',
    description: 'Australian wreckers and recycled auto parts',
    searchUrl: (q) => 'https://partsonline.com.au/search?q=${enc(q)}',
    usedParts: true,
  ),
  Marketplace(
    name: 'PartsClub',
    description: 'Verified Australian wreckers and used parts',
    searchUrl: (q) => 'https://partsclub.com.au/search?q=${enc(q)}',
    usedParts: true,
  ),
  Marketplace(
    name: 'Findapart',
    description: 'Australian locator for car, 4WD, motorcycle, truck and marine parts',
    searchUrl: (q) => 'https://www.findapart.com.au/',
    usedParts: true,
    newParts: true,
  ),
  Marketplace(
    name: 'Parts Plus Australia',
    description: 'Large network of recycled auto parts',
    searchUrl: (q) => 'https://partsplus.com.au/',
    usedParts: true,
  ),
  Marketplace(
    name: 'Rare Spares',
    description: 'Australian new reproduction and restoration parts',
    searchUrl: (q) => 'https://www.rarespares.net.au/search?q=${enc(q)}',
    usedParts: false,
  ),
  Marketplace(
    name: 'Supercheap Auto',
    description: 'New automotive parts and accessories',
    searchUrl: (q) => 'https://www.supercheapauto.com.au/search?q=${enc(q)}',
    usedParts: false,
  ),
  Marketplace(
    name: 'Repco',
    description: 'New automotive parts and accessories',
    searchUrl: (q) => 'https://www.repco.com.au/search?q=${enc(q)}',
    usedParts: false,
  ),
  Marketplace(
    name: 'Burson Auto Parts',
    description: 'New parts and workshop products',
    searchUrl: (q) => 'https://www.burson.com.au/search?q=${enc(q)}',
    usedParts: false,
  ),
  Marketplace(
    name: 'NAPA Auto Parts Australia',
    description: 'New automotive parts',
    searchUrl: (q) => 'https://www.napaparts.com.au/search?q=${enc(q)}',
    usedParts: false,
  ),
  Marketplace(
    name: 'Sparesbox',
    description: 'New 4WD, performance and automotive parts',
    searchUrl: (q) => 'https://www.sparesbox.com.au/search?q=${enc(q)}',
    usedParts: false,
  ),
  Marketplace(
    name: 'RockAuto',
    description: 'Large international new-parts catalogue',
    searchUrl: (q) => 'https://www.rockauto.com/en/catalog/?keyword=${enc(q)}',
    usedParts: false,
  ),
  Marketplace(
    name: 'Amazon Australia',
    description: 'New parts and accessories',
    searchUrl: (q) => 'https://www.amazon.com.au/s?k=${enc(q)}',
    usedParts: false,
  ),
  Marketplace(
    name: 'OzMoto',
    description: 'Australian motorcycle parts and accessories marketplace',
    searchUrl: (q) => 'https://ozmoto.au/search?q=${enc(q)}',
    vehicleType: VehicleType.motorcycle,
    newParts: true,
    usedParts: true,
  ),
  Marketplace(
    name: 'Bike Part Out',
    description: 'Motorcycle dismantling and used parts',
    searchUrl: (q) => 'https://www.ebay.com.au/sch/i.html?_nkw=${enc(q + " motorcycle parts")}',
    vehicleType: VehicleType.motorcycle,
    usedParts: true,
  ),
  Marketplace(
    name: 'Truck & Trailer Parts',
    description: 'Search engine for truck/commercial parts',
    searchUrl: (q) => 'https://www.google.com/search?q=${enc(q + " truck parts Australia")}',
    vehicleType: VehicleType.truck,
    newParts: true,
    usedParts: true,
  ),
  Marketplace(
    name: 'Marine / Boat Parts',
    description: 'Search Australian marine parts suppliers and marketplaces',
    searchUrl: (q) => 'https://www.google.com/search?q=${enc(q + " boat marine parts Australia")}',
    vehicleType: VehicleType.boat,
    newParts: true,
    usedParts: true,
  ),
];


class VehicleIdentity {
  final String yearRange;
  final String make;
  final String model;
  final String description;
  final String? engine;
  final String? body;

  const VehicleIdentity({
    required this.yearRange,
    required this.make,
    required this.model,
    required this.description,
    this.engine,
    this.body,
  });
}

String plateApiUrl(String plate, String state) =>
    'https://plateapi.com.au/api/v1/lookup?plate=${enc(plate)}&state=$state';

class PartFinderApp extends StatelessWidget {
  const PartFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PartFinder',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VehicleType vehicle = VehicleType.car;
  String condition = 'All';
  final make = TextEditingController();
  final model = TextEditingController();
  final year = TextEditingController();
  final part = TextEditingController();
  final partNumber = TextEditingController();
  final vin = TextEditingController();
  final rego = TextEditingController();
  String regoState = 'QLD';
  VehicleIdentity? identifiedVehicle;
  bool identifying = false;

  String get vehicleLabel {
    switch (vehicle) {
      case VehicleType.car: return 'Car / 4WD';
      case VehicleType.motorcycle: return 'Motorcycle';
      case VehicleType.truck: return 'Truck';
      case VehicleType.boat: return 'Boat / Marine';
    }
  }

  String get query {
    final bits = [
      year.text, make.text, model.text, part.text, partNumber.text
    ].where((x) => x.trim().isNotEmpty).toList();
    return bits.join(' ');
  }

  List<Marketplace> get filtered {
    return marketplaces.where((m) {
      final vehicleOK = m.vehicleType == null || m.vehicleType == vehicle;
      final conditionOK = condition == 'All' ||
          (condition == 'New' && m.newParts) ||
          (condition == 'Used' && m.usedParts);
      return vehicleOK && conditionOK;
    }).toList();
  }

  Future<void> openMarketplace(Marketplace m) async {
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a vehicle or part first.')),
      );
      return;
    }
    final uri = Uri.parse(m.searchUrl(query));
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open ${m.name}')),
        );
      }
    }
  }


  Future<void> identifyByRego() async {
    final plate = rego.text.trim().toUpperCase();
    if (plate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a registration plate first.')),
      );
      return;
    }
    setState(() => identifying = true);
    try {
      final response = await http.get(Uri.parse(plateApiUrl(plate, regoState)));
      if (response.statusCode != 200) throw Exception('Lookup failed');
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final v = data['vehicle'] as Map<String, dynamic>?;
      if (v == null) throw Exception('Vehicle not found');
      final identity = VehicleIdentity(
        yearRange: '${v['year_range'] ?? ''}',
        make: '${v['make'] ?? ''}',
        model: '${v['model'] ?? ''}',
        description: '${v['description'] ?? ''}',
        engine: v['engine']?.toString(),
        body: v['body']?.toString(),
      );
      setState(() {
        identifiedVehicle = identity;
        year.text = identity.yearRange;
        make.text = identity.make;
        model.text = identity.model;
      });
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not identify that rego. Check the plate and state.')),
        );
      }
    } finally {
      if (mounted) setState(() => identifying = false);
    }
  }

  void applyVehicle(VehicleIdentity v) {
    setState(() {
      identifiedVehicle = v;
      year.text = v.yearRange;
      make.text = v.make;
      model.text = v.model;
    });
  }

  Future<void> openPpsr() async {
    final vinValue = vin.text.trim().toUpperCase();
    final uri = Uri.parse(
      vinValue.isNotEmpty
        ? 'https://www.ppsr.gov.au/carcheck'
        : 'https://www.ppsr.gov.au/carcheck'
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    for (final c in [make, model, year, part, partNumber, vin, rego]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PartFinder'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'About',
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'PartFinder',
              applicationVersion: '0.1.0',
              children: const [
                Text('Search many vehicle-parts marketplaces from one place.'),
              ],
            ),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Find your part', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          SegmentedButton<VehicleType>(
            segments: const [
              ButtonSegment(value: VehicleType.car, label: Text('Cars'), icon: Icon(Icons.directions_car)),
              ButtonSegment(value: VehicleType.motorcycle, label: Text('Bikes'), icon: Icon(Icons.two_wheeler)),
              ButtonSegment(value: VehicleType.truck, label: Text('Trucks'), icon: Icon(Icons.local_shipping)),
              ButtonSegment(value: VehicleType.boat, label: Text('Boats'), icon: Icon(Icons.directions_boat)),
            ],
            selected: {vehicle},
            onSelectionChanged: (s) => setState(() => vehicle = s.first),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: condition,
            decoration: const InputDecoration(labelText: 'Condition', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'All', child: Text('New + Used')),
              DropdownMenuItem(value: 'New', child: Text('New only')),
              DropdownMenuItem(value: 'Used', child: Text('Used only')),
            ],
            onChanged: (v) => setState(() => condition = v ?? 'All'),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Identify your vehicle', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                TextField(
                  controller: vin,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'VIN (optional)',
                    hintText: '17-character VIN',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: TextField(
                      controller: rego,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        labelText: 'Rego / plate',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 105,
                    child: DropdownButtonFormField<String>(
                      value: regoState,
                      decoration: const InputDecoration(
                        labelText: 'State',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'ACT', child: Text('ACT')),
                        DropdownMenuItem(value: 'NSW', child: Text('NSW')),
                        DropdownMenuItem(value: 'NT', child: Text('NT')),
                        DropdownMenuItem(value: 'QLD', child: Text('QLD')),
                        DropdownMenuItem(value: 'SA', child: Text('SA')),
                        DropdownMenuItem(value: 'TAS', child: Text('TAS')),
                        DropdownMenuItem(value: 'VIC', child: Text('VIC')),
                        DropdownMenuItem(value: 'WA', child: Text('WA')),
                      ],
                      onChanged: (v) => setState(() => regoState = v ?? 'QLD'),
                    ),
                  ),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: identifying ? null : identifyByRego,
                      icon: identifying
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.badge),
                      label: const Text('Identify by rego'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: openPpsr,
                    icon: const Icon(Icons.verified_user),
                    label: const Text('PPSR'),
                  ),
                ]),
                if (identifiedVehicle != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    '${identifiedVehicle!.yearRange} ${identifiedVehicle!.make} ${identifiedVehicle!.model}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(identifiedVehicle!.description),
                ],
              ]),
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: TextField(controller: year, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Year', border: OutlineInputBorder()))),
            const SizedBox(width: 8),
            Expanded(child: TextField(controller: make, decoration: const InputDecoration(labelText: 'Make', border: OutlineInputBorder()))),
          ]),
          const SizedBox(height: 12),
          TextField(controller: model, decoration: const InputDecoration(labelText: 'Model / variant', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: part, decoration: const InputDecoration(labelText: 'Part you need', hintText: 'e.g. alternator, T5 output shaft, fairing', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: partNumber, decoration: const InputDecoration(labelText: 'Part number (optional)', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.search),
            label: const Text('Show marketplaces'),
          ),
          const SizedBox(height: 20),
          Text(
            '${filtered.length} marketplaces / search sources',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...filtered.map((m) => Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(
                m.usedParts && m.newParts ? Icons.swap_horiz :
                m.usedParts ? Icons.recycling : Icons.inventory_2,
              )),
              title: Text(m.name),
              subtitle: Text(m.description),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => openMarketplace(m),
            ),
          )),
          const SizedBox(height: 12),
          const Text(
            'Tip: use the exact OEM/part number whenever possible. '
            'PartFinder opens each marketplace with your search terms; '
            'the marketplace itself controls stock, compatibility and listing availability.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
