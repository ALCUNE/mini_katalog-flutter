// lib/models/product_data.dart
import 'dart:collection';
import 'dart:core';

import 'product.dart';

final List<Map<String, dynamic>> _productsJson = [
  {
    'id': 1,
    'name': 'Kablosuz Kulaklık',
    'category': 'Elektronik',
    'price': 549.99,
    'stock': 35,
    'description':
        'Gürültü önleyici, 30 saat pil ömrü. Bluetooth 5.3 destekli.',
    'imageUrl': 'assets/images/kulaklık.jpg'
  },
  {
    'id': 2,
    'name': 'Akıllı Saat',
    'category': 'Elektronik',
    'price': 1299.00,
    'stock': 20,
    'description': 'Nabız takibi, bildirim ve GPS. Su geçirmez (IP68).',
    'imageUrl': 'assets/images/saat.jpg'
  },
  {
    'id': 3,
    'name': 'Taşınabilir Sarj Cihazı',
    'category': 'Elektronik',
    'price': 249.90,
    'stock': 50,
    'description': '20.000 mAh, çift USB-C çıkışı. Hızlı sarj destekli.',
    'imageUrl': 'assets/images/sarj.jpg'
  },
  {
    'id': 4,
    'name': 'Pamuklu T-Shirt',
    'category': 'Giyim',
    'price': 89.90,
    'stock': 18,
    'description': '100 organik pamuk, unisex kesim. XS-3XL beden.',
    'imageUrl': 'assets/images/tshirt.jpg'
  },
  {
    'id': 5,
    'name': 'Slim Fit Pantolon',
    'category': 'Giyim',
    'price': 199.00,
    'stock': 12,
    'description': '4 mevsim kumaş, esnek bel. Koyu lacivert.',
    'imageUrl': 'assets/images/pantolon.jpg'
  },
  {
    'id': 6,
    'name': 'Temiz Kod',
    'category': 'Kitap',
    'price': 185.00,
    'stock': 40,
    'description': 'Robert C. Martin - yazılımcı klasigi. Türkçe çeviri.',
    'imageUrl': 'assets/images/kitap1.jpg'
  },
  {
    'id': 7,
    'name': 'Dune',
    'category': 'Kitap',
    'price': 95.00,
    'stock': 55,
    'description': 'Frank Herbert - bilim kurgu basyapıtı. Ciltli baskı.',
    'imageUrl': 'assets/images/kitap2.jpg'
  },
  {
    'id': 8,
    'name': 'Nemlendirici Krem',
    'category': 'Kozmetik',
    'price': 149.90,
    'stock': 8,
    'description': 'Hyaluronik asit ve E vitamini. 50ml tup.',
    'imageUrl': 'assets/images/krem.jpg'
  },
  {
    'id': 9,
    'name': 'Ahşap Kesme Tahtası',
    'category': 'Ev ve Yaşam',
    'price': 179.00,
    'stock': 30,
    'description': 'Bambu, antibakteriyel yüzey. 35x25 cm.',
    'imageUrl': 'assets/images/tahta.jpg'
  },
  {
    'id': 10,
    'name': 'Cam Bardak Seti',
    'category': 'Ev ve Yaşam',
    'price': 259.00,
    'stock': 15,
    'description': '6 lı set, borosilikat cam. ',
    'imageUrl': 'assets/images/bardak.jpg'
  },
];

List<Product> getProducts() {
  return _productsJson.map((json) => Product.fromJson(json)).toList();
}

List<Product> searchProducts(List<Product> products, String query) {
  if (query.isEmpty) return products;
  final q = query.toLowerCase();
  return products
      .where((p) =>
          p.name.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q))
      .toList();
}
