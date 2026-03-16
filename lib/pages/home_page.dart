// lib/pages/home_page.dart
//
// Bilgi: StatefulWidget kullanılır çünkü arama, filtreleme ve sepet
// değiştiğinde UI'nin yeniden çizilmesi (setState) gerekir.
// Navigator.push ile detay sayfasına geçiş yapılır.

import 'package:flutter/material.dart';
import 'dart:core';
import '../models/product.dart';
import '../models/product_data.dart';
import '../widgets/product_card.dart';
import 'detail_page.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ── State değişkenleri ─────────────────────────────────────
  final List<Product> _allProducts = getProducts(); // Tüm ürünler
  List<Product> _filtered = []; // Filtrelenmiş liste
  final List<Product> _cart = []; // Sepet (simülasyon)
  String _selectedCategory = 'Tümü'; // Seçili kategori
  final TextEditingController _searchController = TextEditingController();

  // Kategoriler listesi
  final List<String> _categories = [
    'Tümü',
    'Elektronik',
    'Giyim',
    'Kitap',
    'Kozmetik',
    'Ev ve Yaşam'
  ];

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_allProducts); // Başlangıçta tümü göster

    // Arama kutusunu dinle
    _searchController.addListener(_applyFilters);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Arama + Kategori filtresi ──────────────────────────────
  // Bilgi: setState() çağrısı Flutter'a "UI'yi yeniden çiz" der.
  void _applyFilters() {
    setState(() {
      final query = _searchController.text;
      List<Product> result = _allProducts;

      // Kategori filtresi
      if (_selectedCategory != 'Tümü') {
        result = result.where((p) => p.category == _selectedCategory).toList();
      }

      // Arama filtresi
      result = searchProducts(result, query);
      _filtered = result;
    });
  }

  // ── Sepete ekle ────────────────────────────────────────────
  void _addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
    // SnackBar ile kullanıcıya geri bildirim
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} sepete eklendi 🛒'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.orange.shade800,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ── Detay sayfasına git ────────────────────────────────────
  // Bilgi: Navigator.push, yeni sayfayı yığına (stack) ekler.
  // Route Arguments olarak Product nesnesi taşınır.
  void _goToDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          product: product,
          onAddToCart: () => _addToCart(product),
        ),
      ),
    );
  }

  // ── Sepet sayfasına git ────────────────────────────────────
  // Bilgi: Navigator.push future döndürür. Sipariş onaylandığında
  // CartPage, sipariş edilen ürünlerin id listesini geri gönderir.
  // Bu liste ile her ürünün stoğunu 1 azaltıyoruz.
  void _goToCart() async {
    final result = await Navigator.push<List<int>>(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(cartItems: _cart),
      ),
    );

    // Sipariş verildi — stokları güncelle
    if (result != null && result.isNotEmpty) {
      setState(() {
        for (final id in result) {
          final index = _allProducts.indexWhere((p) => p.id == id);
          if (index != -1 && _allProducts[index].stock > 0) {
            final p = _allProducts[index];
            _allProducts[index] = Product(
              id: p.id,
              name: p.name,
              category: p.category,
              price: p.price,
              stock: p.stock - 1,
              description: p.description,
              imageUrl: p.imageUrl,
            );
          }
        }
        _cart.clear();
        _applyFilters();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Siparişiniz alındı! Stoklar güncellendi.'),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade700,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),

      // ── AppBar ─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2C0A),
        foregroundColor: Colors.white,
        title: const Text(
          'Mini Katalog',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          // Sepet ikonu + ürün sayacı
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: _goToCart,
                tooltip: 'Sepetim',
              ),
              if (_cart.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade400,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${_cart.length}',
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Column(
        children: [
          // ── Arama Kutusu ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Ürün ara…',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.orange.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: Colors.orange.shade400, width: 2),
                ),
              ),
            ),
          ),

          // ── Kategori Filtresi (yatay scroll) ─────────────
          // Bilgi: SingleChildScrollView ile taşan içerik yatay kaydırılır.
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => _selectedCategory = cat);
                      _applyFilters();
                    },
                    selectedColor: Colors.orange.shade700,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.orange.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    backgroundColor: Colors.orange.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    side: BorderSide(
                        color: isSelected
                            ? Colors.orange.shade700
                            : Colors.orange.shade200),
                  ),
                );
              },
            ),
          ),

          // ── Sonuç sayısı ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${_filtered.length} ürün listeleniyor',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          ),

          // ── Ürün Listesi (GridView) ───────────────────────
          // Bilgi: Expanded, kalan tüm alanı kaplar.
          // GridView.builder, sadece ekranda görünen widget'ları oluşturur
          // (performans optimizasyonu).
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text('Ürün bulunamadı.',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade500)),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 sütunlu grid
                      childAspectRatio: 0.72, // kart boy/en oranı
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final product = _filtered[index];
                      return ProductCard(
                        product: product,
                        onTap: () => _goToDetail(product),
                        onAddToCart: () => _addToCart(product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
