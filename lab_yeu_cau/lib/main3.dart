class Product {
  final int id;
  final String name;
  final double? price;
  final List<String> tags;

  Product({
    required this.id,
    required this.name,
    this.price,
    required this.tags,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    final String parseName = json['name']?.toString() ?? 'San pham an';
    double? parsePrice = json["price"] != null
        ? double.tryParse(json["price"].toString())
        : null;
    final List<String> parseTags =
        (json['tags'] as List?)?.map((item) => item.toString()).toList() ?? [];
    return Product(
      id: json['id'] as int,
      name: parseName,
      price: parsePrice,
      tags: parseTags,
    );
  }
  @override
  String toString() => "[$id] $name - \$${price ?? 'N/A'} - $tags";
}


void main() {
  List<Map<String, dynamic>> rawApiData = [
    {"id": 1, "name": "Laptop", "price": 1200.5, "tags": ["tech"]},
    {"id": 2, "name": "Mouse", "price": "25.0", "tags": null},
    {"id": 3, "name": null, "price": null, "tags": ["office"]},
    {"id": 4, "name": "Monitor", "price": 300, "tags": ["tech", "screen"]},

  ];
List<Product> validProducts = rawApiData
    .map((json) => Product.fromJson(json))
    .toList();

List<Product> premiumCatalog = [
  for (var product in validProducts)
    if (product.price != null && product.price! > 100)
      product,

  if (validProducts.where((p) => p.price != null && p.price! > 100).length > 1)
    Product(
      id: 999,
      name: "Quà tặng VIP",
      price: 0.0,
      tags: ["vip", "gift"],
    ),
];

premiumCatalog.forEach(print);
}