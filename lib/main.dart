// lib/main.dart
//
// Bilgi: main() fonksiyonu uygulamanın başlangıç noktasıdır.
// runApp(), Flutter'ın widget ağacını (widget tree) başlatır.
// MaterialApp, Material Design temasını ve route yapısını tanımlar.

import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,  // Debug bandını gizle

      // ── Tema ────────────────────────────────────────────────
      // Bilgi: ThemeData, uygulamanın tüm renk ve tipografi
      // varsayılanlarını merkezi olarak belirler.
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD4721F),  // Turuncu ana renk
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFDF6EE),

        // AppBar teması
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A2C0A),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),

        // Card teması
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
        ),

        // ElevatedButton teması
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4721F),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),

      // ── Named Routes ────────────────────────────────────────
      // Bilgi: Named Routes ile sayfa adları merkezi olarak yönetilir.
      // Navigator.pushNamed(context, '/home') ile kullanılabilir.
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        // Detay ve Sepet sayfaları argument gerektirdiğinden
        // MaterialPageRoute ile açılmaktadır (home_page.dart içinde).
      },
    );
  }
}
