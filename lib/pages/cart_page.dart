// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.cartItems);
  }

  // Sepetten ürün sil
  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    widget.cartItems.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ürün sepetten çıkarıldı.'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Sipariş ver — stok düşülecek ürünlerin id listesini geri döndür
  void _placeOrder(double total) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('🎉 Sipariş Alındı!'),
        content: Text(
          '${_items.length} ürün için toplam '
          '${total.toStringAsFixed(2)} ₺ tutarında '
          'siparişiniz alınmıştır.\n\n'
          '(Bu bir simülasyondur.)'),
        actions: [
          TextButton(
            onPressed: () {
              // Bilgi: Sipariş onayında stok düşülecek ürünlerin
              // id listesini Navigator.pop ile ana sayfaya gönderiyoruz.
              final List<int> orderedIds = _items.map((p) => p.id).toList();
              Navigator.pop(context);           // dialog kapat
              Navigator.pop(context, orderedIds); // sepet kapat + id listesi gönder
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double total = _items.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2C0A),
        foregroundColor: Colors.white,
        title: Text(
          'Sepetim  (${_items.length} ürün)',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 72, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text('Sepetiniz boş.', style: TextStyle(fontSize: 18, color: Colors.grey.shade500)),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Alışverişe Devam Et →', style: TextStyle(color: Colors.orange.shade700)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final product = _items[index];
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              product.imageUrl,
                              width: 56, height: 56, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 56, height: 56,
                                color: Colors.orange.shade100,
                                child: const Icon(Icons.image_outlined),
                              ),
                            ),
                          ),
                          title: Text(product.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          subtitle: Text(product.category, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${product.price.toStringAsFixed(2)} ₺',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () => _removeItem(index),
                                icon: const Icon(Icons.delete_outline_rounded),
                                color: Colors.red.shade400,
                                iconSize: 22,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                tooltip: 'Sepetten Çıkar',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Toplam Tutar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          Text('${total.toStringAsFixed(2)} ₺',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange.shade800)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => _placeOrder(total),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text('Sipariş Ver  →', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
