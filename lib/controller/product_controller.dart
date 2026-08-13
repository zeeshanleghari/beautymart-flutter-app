import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskController {
  static final TaskController _instance = TaskController._internal();
  factory TaskController() => _instance;
  TaskController._internal();

  static const String _baseUrl = "https://dummyjson.com/products";
  final List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;
  int get cartCount => _cart.length;

  double get totalPrice {
    double total = 0.0;
    for (var item in _cart) {
      total += (item["price"] as num).toDouble();
    }
    return total;
  }

  Future<List<dynamic>> getAllProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["products"];
    }
    return [];
  }

  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse("$_baseUrl/category-list"));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<String>();
    }
    return [];
  }

  Future<List<dynamic>> getProductsByCategory(String category) async {
    final response = await http.get(Uri.parse("$_baseUrl/category/$category"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["products"];
    }
    return [];
  }

  void addToCart(dynamic product) {
    _cart.add(product);
  }

  void removeFromCart(int index) {
    _cart.removeAt(index);
  }
}
