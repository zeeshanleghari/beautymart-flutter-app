import 'package:flutter/material.dart';

class ProudctDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  // ignore: strict_top_level_inference
  const ProudctDetailsScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product["title"] ?? "Product",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // SizedBox(height: 200),
              Image.network(
                product["images"][0],
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product["title"] ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "\$${product["price"]}",
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product["description"] ?? ""),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Rating: ${product["rating"]} ⭐"),
              ),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(
                      double.infinity,
                      50,
                    ), // Full width, 50 height
                  ),
                  onPressed: () {},
                  child: Text("Add T0 Cart"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
