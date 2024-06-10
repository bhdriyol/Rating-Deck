import 'package:flutter/material.dart';
import 'package:project_f/Widgets/reviews_card.dart';

class Product {
  final List<String> imagePaths;
  final String title;
  final String description;
  final String price;
  final String category;
  final double? rating;
  int id;
  final List<Reviews> comments;

  Product({
    required this.imagePaths,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.id,
    this.comments = const [],
  });
}

class ProductManager with ChangeNotifier {
  final List<Product> _products = [
    Product(
        imagePaths: [
          "assets/images/iph15.png",
          "assets/images/iph152.png",
          "assets/images/iph153.png",
        ],
        title: 'iPhone 15',
        description: '6.1" iPhone 15 128 GB Black',
        price: "50.999,00",
        category: 'Phones',
        rating: 5,
        id: 0,
        comments: [
          Reviews(
              rating: 5,
              description:
                  "Paketleme çok iyi yapılmıştı, 2 gün içinde elime ulaştı. iPhone 11’den geçtim, günlük kullanımda gözle görülür bir fark göremedim ama ekran renk tonu daha sarımtırak ve daha az göz yorucu. 11 ve 15 arasındaki farkları fotograf çekim kalitesi dışında oyun oynamayan ya da foto/video düzenleme vs yapmayan normal bir kullanıcının anlama şansı pek yok. Sadece konuşurken seste kısılma ve batarya %80 altına düştüğü için değiştirdim."),
          Reviews(rating: 5, description: "Mükemmeeeel hızlı teslimat"),
        ]),
    Product(
        imagePaths: [
          "assets/images/mbp24.png",
          "assets/images/mbp242.png",
          "assets/images/mbp243.png",
        ],
        title: 'MacBook Pro',
        description: 'Apple MacBook Pro M3 Pro 18GB 512GB SSD MacOS 14"',
        price: "60.999,00",
        category: 'Computers',
        rating: 5,
        id: 1,
        comments: [
          Reviews(rating: 5, description: "Sıkıntısız elime ulaştı"),
          Reviews(
              rating: 5,
              description:
                  "Alet canavar zaten fazla söze gerek yok. Ama benim gibi düşünen olmuşsa diye şunu belirtebilirim, ben bundan önce M1 Air kullanıyordum performansı gayet yeterliydi, fansız olması muhteşemdi hiç ses yapmıyordu doğal olarak. Bu makinenin fanlı olmasından dolayı acaba ses yapar mı diye endişe ediyordum ama günlük kullanımda makineyi ısıtacak bir işlem yapmazsanız fansız gibi hiç çalışmaya ihtiyaç duymadığından ses de sıfır."),
        ]),
  ];

  final List<Product> _favorites = [];

  List<Product> get products => _products;
  List<Product> get favorites => _favorites;

  static int _selectedProductId = -1;

  static void setProductId(int productId) {
    _selectedProductId = productId;
  }

  List<Reviews> getCommentsBySelectedProductId() {
    if (_selectedProductId == -1) return [];

    final product =
        _products.firstWhere((product) => product.id == _selectedProductId);
    return product.comments;
  }

  void toggleFavorite(Product product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.contains(product);
  }
}
