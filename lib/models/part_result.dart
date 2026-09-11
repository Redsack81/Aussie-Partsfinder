class PartResult {
  final String title;
  final String marketplace;
  final String imageUrl;
  final String itemUrl;
  final String condition;
  final String location;
  final double? price;
  final String priceText;

  const PartResult({
    required this.title,
    required this.marketplace,
    required this.imageUrl,
    required this.itemUrl,
    this.condition = '',
    this.location = '',
    this.price,
    this.priceText = '',
  });

  factory PartResult.fromJson(Map<String, dynamic> json) {
    double? parsedPrice;

    final rawPrice = json['price'];

    if (rawPrice is num) {
      parsedPrice = rawPrice.toDouble();
    } else if (rawPrice is String) {
      parsedPrice = double.tryParse(
        rawPrice.replaceAll(
          RegExp(r'[^0-9.]'),
          '',
        ),
      );
    }

    return PartResult(
      title: json['title']?.toString() ?? '',
      marketplace:
          json['marketplace']?.toString() ??
          json['source']?.toString() ??
          '',
      imageUrl:
          json['imageUrl']?.toString() ??
          json['image_url']?.toString() ??
          json['image']?.toString() ??
          '',
      itemUrl:
          json['itemUrl']?.toString() ??
          json['item_url']?.toString() ??
          json['url']?.toString() ??
          '',
      condition:
          json['condition']?.toString() ?? '',
      location:
          json['location']?.toString() ?? '',
      price: parsedPrice,
      priceText:
          json['priceText']?.toString() ??
          json['price_text']?.toString() ??
          (parsedPrice == null
              ? ''
              : '\$${parsedPrice.toStringAsFixed(2)}'),
    );
  }
}
