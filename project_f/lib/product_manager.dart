import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  factory Product.fromJson(Map<String, dynamic> json) {
    var list = json['imagePaths'] as List;
    List<String> imagePathsList = list.map((i) => i.toString()).toList();

    var commentsFromJson = json['comments'] as List;
    List<Reviews> commentsList =
        commentsFromJson.map((i) => Reviews.fromJson(i)).toList();

    double? rating = json['rating'] is int
        ? (json['rating'] as int).toDouble()
        : json['rating'];

    return Product(
      imagePaths: imagePathsList,
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      rating: rating,
      id: json['id'],
      comments: commentsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> comments = this.comments.map((i) => i.toJson()).toList();

    return {
      'imagePaths': imagePaths,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'rating': rating,
      'id': id,
      'comments': comments,
    };
  }
}

class Reviews {
  final int rating;
  final String description;

  Reviews({required this.rating, required this.description});

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      rating: json['rating'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'description': description,
    };
  }
}

Future<List<Product>> fetchProducts() async {
  final String response =
      await rootBundle.loadString('assets/data/products.json');
  final data = await json.decode(response) as List;
  return data.map((json) => Product.fromJson(json)).toList();
}

class ProductManager with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _favorites = [];

  List<Product> get products => _products;
  List<Product> get favorites => _favorites;

  static int _selectedProductId = -1;

  static void setProductId(int productId) {
    _selectedProductId = productId;
  }

  List<Reviews> getCommentsBySelectedProductId() {
    if (_selectedProductId == -1) return [];

    try {
      final product =
          _products.firstWhere((product) => product.id == _selectedProductId);
      return product.comments;
    } catch (e) {
      return [];
    }
  }

  void toggleFavorite(Product product) async {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    await saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.contains(product);
  }

  Future<void> loadProducts() async {
    _products = await fetchProducts();
    await loadFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = _favorites.map((product) => product.id).toList();
    await prefs.setStringList(
        'favoriteIds', favoriteIds.map((id) => id.toString()).toList());
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favoriteIds') ?? [];

    _favorites = _products
        .where((product) => favoriteIds.contains(product.id.toString()))
        .toList();
  }
}
