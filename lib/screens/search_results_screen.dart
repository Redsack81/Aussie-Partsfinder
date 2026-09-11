import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/part_result.dart';
import '../services/marketplace_links.dart';
import '../services/parts_search_service.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;
  final String vehicleType;

  const SearchResultsScreen({
    super.key,
    required this.query,
    required this.vehicleType,
  });

  @override
  State<SearchResultsScreen> createState() =>
      _SearchResultsScreenState();
}

class _SearchResultsScreenState
    extends State<SearchResultsScreen> {
  final PartsSearchService _service = PartsSearchService();

  bool _loading = true;
  bool _includeNew = true;
  bool _includeUsed = true;

  String _sort = 'Relevance';
  String? _error;

  List<PartResult> _results = [];

  @override
  void initState() {
    super.initState();
    _runSearch();
  }

  Future<void> _runSearch() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final results = await _service.search(
        query: widget.query,
        vehicleType: widget.vehicleType,
        includeNew: _includeNew,
        includeUsed: _includeUsed,
      );

      setState(() {
        _results = _sortResults(results);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _results = [];
        _loading = false;
      });
    }
  }

  List<PartResult> _sortResults(
    List<PartResult> input,
  ) {
    final results = [...input];

    if (_sort == 'Price low-high') {
      results.sort(
        (a, b) => (a.price ?? double.infinity)
            .compareTo(
          b.price ?? double.infinity,
        ),
      );
    }

    if (_sort == 'Price high-low') {
      results.sort(
        (a, b) => (b.price ?? -1).compareTo(
          a.price ?? -1,
        ),
      );
    }

    return results;
  }

  Future<void> _openItem(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) return;

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceLinks =
        MarketplaceLinks.forQuery(widget.query);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: RefreshIndicator(
        onRefresh: _runSearch,
        child: ListView(
          padding: const EdgeInsets.all(14),
          children: [
            Text(
              widget.query,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment:
                  WrapCrossAlignment.center,
              children: [
                FilterChip(
                  label: const Text('New'),
                  selected: _includeNew,
                  onSelected: (value) {
                    setState(() {
                      _includeNew = value;
                    });

                    _runSearch();
                  },
                ),

                FilterChip(
                  label: const Text('Used'),
                  selected: _includeUsed,
                  onSelected: (value) {
                    setState(() {
                      _includeUsed = value;
                    });

                    _runSearch();
                  },
                ),

                DropdownButton<String>(
                  value: _sort,
                  items: const [
                    DropdownMenuItem(
                      value: 'Relevance',
                      child: Text('Relevance'),
                    ),
                    DropdownMenuItem(
                      value: 'Price low-high',
                      child: Text('Price low-high'),
                    ),
                    DropdownMenuItem(
                      value: 'Price high-low',
                      child: Text('Price high-low'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _sort = value;
                      _results =
                          _sortResults(_results);
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (_loading)
              const Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                  child:
                      CircularProgressIndicator(),
                ),
              ),

            if (!_loading && _error != null)
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.all(14),
                  child: Text(
                    'Live search error: $_error',
                  ),
                ),
              ),

            if (!_loading &&
                _results.isNotEmpty) ...[
              Text(
                '${_results.length} listings found',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              ..._results.map(
                (result) => _resultCard(result),
              ),
            ],

            if (!_loading &&
                _results.isEmpty) ...[
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'This screen is ready to show '
                    'live photos, prices, sellers '
                    'and direct listing links. '
                    'The marketplace API/backend '
                    'still needs to be connected.',
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),

            const Text(
              'Search marketplaces',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            ...marketplaceLinks.map(
              (marketplace) => Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.storefront,
                  ),
                  title:
                      Text(marketplace.name),
                  subtitle: Text(
                    widget.query,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(
                    Icons.open_in_new,
                  ),
                  onTap: () {
                    MarketplaceLinks.open(
                      marketplace.url,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _resultCard(PartResult result) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          _openItem(result.itemUrl);
        },
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: result.imageUrl.isEmpty
                  ? const Center(
                      child: Icon(
                        Icons
                            .image_not_supported_outlined,
                        size: 42,
                      ),
                    )
                  : Image.network(
                      result.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) {
                        return const Center(
                          child: Icon(
                            Icons
                                .broken_image_outlined,
                          ),
                        );
                      },
                    ),
            ),

            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    if (result
                        .priceText.isNotEmpty)
                      Text(
                        result.priceText,
                        style:
                            const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),

                    const SizedBox(height: 4),

                    Text(
                      [
                        result.marketplace,
                        result.condition,
                        result.location,
                      ]
                          .where(
                            (value) => value
                                .trim()
                                .isNotEmpty,
                          )
                          .join(' • '),
                      maxLines: 2,
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'View item ↗',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
