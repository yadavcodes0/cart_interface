class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String brand;
  final double discountPercentage;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.brand,
    required this.discountPercentage,
    required this.quantity,
  });

  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      name: name,
      brand: brand,
      price: price,
      imageUrl: imageUrl,
      discountPercentage: discountPercentage,
      quantity: quantity ?? this.quantity,
    );
  }

  double get discountedPrice {
    final discounted = price * (1 - discountPercentage / 100);
    return double.parse(discounted.toStringAsFixed(2));
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['title'] ?? 'Unknown Product',
      price: (json['price'] ?? 0).toDouble() * 83,
      imageUrl: json['thumbnail'] ?? 'https://via.placeholder.com/150',
      brand: json['brand'] ?? 'Unknown Brand',
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
    );
  }
}
