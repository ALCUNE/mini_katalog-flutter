// lib/pages/detail_page.dart
//
// Bilgi: Bu sayfa Navigator ile açılır ve Route Arguments olarak
// Product nesnesi taşınır. Navigator.pop() ile geri dönülür.

import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailPage extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const DetailPage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final bool inStock = product.stock > 0;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),

      // ── AppBar ─────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2C0A),
        foregroundColor: Colors.white,
        title: Text(
          product.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        // Bilgi: AppBar'da otomatik olarak geri butonu eklenir.
        // Navigator.pop() tetiklenir.
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Ürün Görseli ──────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 260,
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFF5F0E8),
                  child: const Icon(Icons.image_not_supported_outlined,
                      size: 64, color: Colors.grey),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Kategori + Stok Durumu ────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Kategori etiketi
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange.shade800,
                          ),
                        ),
                      ),
                      // Stok durumu
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: inStock
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: inStock
                                ? Colors.green.shade300
                                : Colors.red.shade300,
                          ),
                        ),
                        child: Text(
                          inStock
                              ? '✓  Stokta  (${product.stock} adet)'
                              : '✗  Tükendi',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: inStock
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ── Ürün Adı ──────────────────────────────
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Fiyat ─────────────────────────────────
                  Text(
                    '${product.price.toStringAsFixed(2)} ₺',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade800,
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),

                  // ── Ürün Açıklaması ───────────────────────
                  const Text(
                    'Ürün Açıklaması',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.description,
                    style: const TextStyle(
                        fontSize: 15, height: 1.6, color: Colors.black87),
                  ),

                  const SizedBox(height: 24),

                  // ── Sepete Ekle Butonu ────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: inStock
                          ? () {
                              onAddToCart();
                              // Geri bildirim verdikten sonra sayfayı kapat
                              Navigator.pop(context);
                            }
                          : null,
                      icon: const Icon(Icons.add_shopping_cart_rounded),
                      label: Text(
                        inStock ? 'Sepete Ekle' : 'Stokta Yok',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade700,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
