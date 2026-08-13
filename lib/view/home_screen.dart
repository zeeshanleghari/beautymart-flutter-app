import 'package:BeautyMart/controller/product_controller.dart';
import 'package:BeautyMart/view/cart_screen.dart';
import 'package:BeautyMart/view/proudct_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _controller = TaskController();
  List<dynamic> _products = [];
  List<String> _categories = ["All"];
  String _selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _loadProducts();
  }

  void _loadCategories() async {
    final categoriesData = await _controller.getCategories();
    setState(() {
      _categories = ["All", ...categoriesData];
    });
  }

  void _loadProducts([String category = "All"]) async {
    setState(() => _selectedCategory = category);

    List<dynamic> productsData;
    if (category == "All") {
      productsData = await _controller.getAllProducts();
    } else {
      productsData = await _controller.getProductsByCategory(category);
    }

    setState(() {
      _products = productsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: badges.Badge(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreens()),
                );
                setState(() {});
              },
              badgeContent: Text(
                '${_controller.cartCount}',
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              showBadge: _controller.cartCount > 0,
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: SizedBox(
              height: 35,
              child: TextField(
                style: const TextStyle(fontSize: 12.0, color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black54,
                    size: 18,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 0,
                  ),
                  hintText: "Search for makeup, skincare & more",
                  hintStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
          // Category filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;

                return GestureDetector(
                  onTap: () => _loadProducts(category),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepPurple : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.deepPurple
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      category[0].toUpperCase() + category.substring(1),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Promotional banner
          Container(
            width: double.infinity,
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Glow Naturally",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Premium beauty products for a radiant you",
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                          ),
                          child: const Text("Shop Now"),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset("assets/image.png", fit: BoxFit.contain),
                ),
              ],
            ),
          ),
          // ✅ Product Grid – no ListTile, no error
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProudctDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            product["images"][0],
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 8, 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product["title"] ?? "No title",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${product["price"]}",
                                      style: const TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_shopping_cart_rounded,
                                        color: Colors.deepPurple,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _controller.addToCart(product);
                                        });
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text("Added to cart!"),
                                            duration: Duration(
                                              milliseconds: 800,
                                            ),
                                          ),
                                        );
                                      },
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
