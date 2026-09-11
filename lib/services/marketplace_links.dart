import 'package:url_launcher/url_launcher.dart';

class MarketplaceLink {
  final String name;
  final String url;

  const MarketplaceLink(
    this.name,
    this.url,
  );
}

class MarketplaceLinks {
  static String _encode(String value) {
    return Uri.encodeQueryComponent(
      value.trim(),
    );
  }

  static List<MarketplaceLink> forQuery(
    String query,
  ) {
    final q = _encode(query);

    return [
      MarketplaceLink(
        'eBay Australia',
        'https://www.ebay.com.au/sch/i.html?_nkw=$q',
      ),
      MarketplaceLink(
        'Gumtree Australia',
        'https://www.gumtree.com.au/s-all/$q/k0',
      ),
      MarketplaceLink(
        'Facebook Marketplace',
        'https://www.facebook.com/marketplace/search/?query=$q',
      ),
      MarketplaceLink(
        'PartsOnline',
        'https://partsonline.com.au/search?q=$q',
      ),
      MarketplaceLink(
        'PartsClub',
        'https://partsclub.com.au/search?q=$q',
      ),
      MarketplaceLink(
        'Findapart',
        'https://www.findapart.com.au/',
      ),
      MarketplaceLink(
        'Parts Plus Australia',
        'https://partsplus.com.au/',
      ),
      MarketplaceLink(
        'Rare Spares',
        'https://www.rarespares.net.au/search?q=$q',
      ),
      MarketplaceLink(
        'Supercheap Auto',
        'https://www.supercheapauto.com.au/search?q=$q',
      ),
      MarketplaceLink(
        'Repco',
        'https://www.repco.com.au/search?q=$q',
      ),
      MarketplaceLink(
        'Sparesbox',
        'https://www.sparesbox.com.au/search?q=$q',
      ),
      MarketplaceLink(
        'Autobarn',
        'https://autobarn.com.au/search?q=$q',
      ),
    ];
  }

  static Future<void> open(
    String url,
  ) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception(
        'Could not open marketplace link.',
      );
    }
  }
}
