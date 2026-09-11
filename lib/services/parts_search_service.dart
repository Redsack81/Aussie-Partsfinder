import '../models/part_result.dart';
import '../models/vehicle.dart';

class PartsSearchService {
  Future<List<PartResult>> searchParts({
    required Vehicle vehicle,
    required String part,
  }) async {
    final query = [
      vehicle.year,
      vehicle.make,
      vehicle.model,
      vehicle.variant,
      part,
    ].where((e) => e.toString().trim().isNotEmpty).join(' ');

    return _buildSearchResults(query);
  }

  Future<List<PartResult>> searchMaintenance({
    required Vehicle vehicle,
    required String item,
  }) async {
    final query = [
      vehicle.year,
      vehicle.make,
      vehicle.model,
      vehicle.variant,
      item,
    ].where((e) => e.toString().trim().isNotEmpty).join(' ');

    return _buildSearchResults(query);
  }

  List<PartResult> _buildSearchResults(String query) {
    final encoded = Uri.encodeComponent(query);

    return [
      PartResult(
        title: '$query - eBay Australia',
        marketplace: 'eBay',
        price: null,
        imageUrl: null,
        url: 'https://www.ebay.com.au/sch/i.html?_nkw=$encoded',
        condition: 'New & Used',
      ),
      PartResult(
        title: '$query - Amazon Australia',
        marketplace: 'Amazon',
        price: null,
        imageUrl: null,
        url: 'https://www.amazon.com.au/s?k=$encoded',
        condition: 'New',
      ),
      PartResult(
        title: '$query - Supercheap Auto',
        marketplace: 'Supercheap Auto',
        price: null,
        imageUrl: null,
        url:
            'https://www.supercheapauto.com.au/search?q=$encoded',
        condition: 'New',
      ),
      PartResult(
        title: '$query - Repco',
        marketplace: 'Repco',
        price: null,
        imageUrl: null,
        url: 'https://www.repco.com.au/search?q=$encoded',
        condition: 'New',
      ),
      PartResult(
        title: '$query - Sparesbox',
        marketplace: 'Sparesbox',
        price: null,
        imageUrl: null,
        url: 'https://www.sparesbox.com.au/search?q=$encoded',
        condition: 'New',
      ),
    ];
  }
}
