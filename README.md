# 📱 Mini Katalog — Flutter Uygulaması

Flutter ile geliştirilmiş eğitim projesi. Ürün listeleme, detay ve sepet simülasyonu içerir.

## Proje Açıklaması

Mini Katalog, Flutter kullanılarak geliştirilmiş temel seviye bir mobil katalog uygulamasıdır. Kullanıcılar ürünleri listeleyebilir, detay sayfasına geçiş yapabilir ve sepete ürün ekleyebilir.

## Kullanılan Flutter Sürümü

Flutter 3.27.4 (Dart SDK dahil)

## Özellikler

- Ana Sayfa — GridView ile ürün kartları
- Kategori filtresi ve arama
- Ürün Detay Sayfası — Navigator + Route Arguments
- Sepet Sayfası — ürün ekleme, silme, stok güncelleme
- Local assets ile ürün görselleri

## Proje Yapısı

```
lib/
├── main.dart                  # Uygulama girişi, MaterialApp
├── models/
│   ├── product.dart           # Product modeli (fromJson/toJson)
│   └── product_data.dart      # Ürün verileri
├── pages/
│   ├── home_page.dart         # Ana sayfa
│   ├── detail_page.dart       # Detay sayfası
│   └── cart_page.dart         # Sepet sayfası
└── widgets/
    └── product_card.dart      # Ürün kartı widget
```

## Çalıştırma Adımları

### Gereksinimler
- Flutter SDK 3.27.4 veya üzeri
- Android Studio (Emulator için)
- VS Code

### Kurulum

1. Repoyu klonla:
```bash
git clone https://github.com/ALCUNE/mini_katalog-flutter.git
cd mini_katalog
```

2. Bağımlılıkları yükle:
```bash
flutter pub get
```

3. Emülatörü başlat (Android Studio üzerinden)

4. Uygulamayı çalıştır:
```bash
flutter run
```

## Ekran Görüntüleri

> Ekran görüntüleri aşağıya eklenecektir.

## Hazırlayan

**Deniz ERDOĞAN**
