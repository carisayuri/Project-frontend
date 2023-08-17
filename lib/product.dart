class Product {
  final int id;
  final String name;
  final int quantity;
  final String category;
  final String image;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.image,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      category: json['category'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }
}