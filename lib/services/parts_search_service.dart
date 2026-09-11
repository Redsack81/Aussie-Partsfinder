import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/part_result.dart';

class PartsSearchService {
  // We will connect this to the live marketplace backend later.
  //
  // Example:
  // static const String baseUrl =
  //     'https://your-api-address.com/api';
  static const String baseUrl = '';

  Future<List<PartResult>> search({
    required String query,
    required String vehicleType,
    bool includeNew = true,
    bool includeUsed = true,
  }) async {
    // Until the live backend is connected, return an empty
    // result list. The marketplace search buttons will still work.
    if (baseUrl.trim().isEmpty) {
      return [];
    }

    final uri = Uri.parse(
      '$baseUrl/search',
    ).replace(
      queryParameters: {
        'q': query,
        'vehicleType': vehicleType,
        'new': includeNew.toString(),
        'used': includeUsed.toString(),
        'country': 'AU',
      },
    );

    final response = await http.get(
      uri,
      headers: const {
        'Accept': 'application/json',
      },
    ).timeout(
      const Duration(seconds: 20),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        'Search service returned ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(response.body);

    final List<dynamic> rows;

    if (decoded is List) {
      rows = decoded;
    } else if (decoded is Map<String, dynamic> &&
        decoded['results'] is List) {
      rows = decoded['results'] as List;
    } else {
      rows = [];
    }

    return rows
        .whereType<Map<String, dynamic>>()
        .map(PartResult.fromJson)
        .where(
          (result) =>
              result.title.isNotEmpty &&
              result.itemUrl.isNotEmpty,
        )
        .toList();
  }
}
