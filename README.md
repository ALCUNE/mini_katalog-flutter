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
<img width="1080" height="2400" alt="Screenshot_1773672300" src="https://github.com/user-attachments/assets/6616418c-8b16-48bf-9a8a-28fdd55fddeb" />
<img width="1080" height="2400" alt="Screenshot_1773672298" src="https://github.com/user-attachments/assets/cf0c6d35-e316-40f5-ad20-87d2bbd780c2" />
<img width="1080" height="2400" alt="Screenshot_1773672287" src="https://github.com/user-attachments/assets/76d0c59a-89d7-4259-9aa8-52dee26dec0b" />
<img width="1080" height="2400" alt="Screenshot_1773672283" src="https://github.com/user-attachments/assets/63b65dd4-5f6f-4ecc-915b-745dbd7e082f" />
<img width="1080" height="2400" alt="Screenshot_1773672279" src="https://github.com/user-attachments/assets/55ce983d-caa0-44b6-b68d-18b18c046d6a" />
<img width="1080" height="2400" alt="Screenshot_1773672273" src="https://github.com/user-attachments/assets/e468ee75-761b-4a95-a0be-946d9147a412" />



## Hazırlayan

**Deniz ERDOĞAN**
