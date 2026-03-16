// lib/models/product.dart
//
// Bilgi: Model sınıfı, uygulama genelinde kullanılacak veri yapısını tanımlar.
// fromJson  → JSON verisini Dart nesnesine dönüştürür (API/simülasyon → uygulama)
// toJson   → Dart nesnesini JSON'a dönüştürür (uygulama → API/depolama)

class Product {
  final int    id;
  final String name;
  final String category;
  final double price;
  final int    stock;
  final String description;
  final String imageUrl;

  // Constructor
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.description,
    required this.imageUrl,
  });

  // JSON → Product (fromJson)
  // Bilgi: API'den gelen Map<String, dynamic> verisini Product nesnesine çevirir.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id:          json['id']          as int,
      name:        json['name']        as String,
      category:    json['category']    as String,
      price:       (json['price'] as num).toDouble(),
      stock:       json['stock']       as int,
      description: json['description'] as String,
      imageUrl:    json['imageUrl']    as String,
    );
  }

  // Product → JSON (toJson)
  // Bilgi: Dart nesnesini tekrar Map'e çevirir. Örn: yerel depolama veya API gönderimi.
  Map<String, dynamic> toJson() {
    return {
      'id':          id,
      'name':        name,
      'category':    category,
      'price':       price,
      'stock':       stock,
      'description': description,
      'imageUrl':    imageUrl,
    };
  }

  // Nesneyi okunabilir biçimde yazdırmak için (debug amaçlı)
  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}
