// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final bool inStock = product.stock > 0;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Ürün görseli (asset) ──────────────────
            Stack(
              children: [
                SizedBox(
                  height: 130,
                  width: double.infinity,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      color: const Color(0xFFF5F0E8),
                      child: const Icon(Icons.image_not_supported_outlined,
                          size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                // Stok etiketi
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: inStock ? Colors.green.shade700 : Colors.red.shade600,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      inStock ? 'Stok: ${product.stock}' : 'Tükendi',
                      style: const TextStyle(
                          color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

            // ── Ürün bilgisi ──────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: TextStyle(
                        fontSize: 9, fontWeight: FontWeight.w700,
                        color: Colors.orange.shade700, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600, height: 1.2),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(2)} ₺',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold,
                            color: Colors.orange.shade800),
                      ),
                      IconButton(
                        onPressed: inStock ? onAddToCart : null,
                        icon: const Icon(Icons.add_shopping_cart_rounded),
                        color: Colors.orange.shade700,
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: 'Sepete Ekle',
                      ),
                    ],
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
