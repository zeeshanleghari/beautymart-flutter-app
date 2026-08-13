# BeautyMart — Flutter Shopping App

A simple e-commerce shopping app built with Flutter, using the [DummyJSON](https://dummyjson.com/) API for product data. This project was built as a learning exercise focused on API integration, state management, and UI design in Flutter.

🔗 **Repo:** [github.com/zeeshanleghari/beautymart-flutter-app](https://github.com/zeeshanleghari/beautymart-flutter-app)

## Features

- 🏠 **Home Screen** — Browse all products with category-based filtering
- 🔍 Search bar UI for products
- 🖼️ Product grid with images, title, and price
- 📄 **Product Details Screen** — View full product info (description, price, rating)
- 🛒 **Cart Screen** — Add/remove products, view total price
- 🔔 Cart badge showing live item count
- 🌐 Live data fetched from a REST API



  

## Tech Stack

- **Flutter** — UI framework
- **Dart** — Programming language
- **http** — For making API requests and handling JSON responses
- **badges** — For the cart item count badge on the home screen
- **DummyJSON API** — Mock REST API for product data

## Project Structure

```
beautymart-flutter-app/
lib/
├── controller/
│   └── product_controller.dart   # Handles API calls, cart logic, and state
├── view/
│   ├── home_screen.dart          # Product listing + category filter
│   ├── cart_screen.dart          # Cart items + total price
│   └── product_details_screen.dart # Single product detail view
└── main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK installed ([installation guide](https://docs.flutter.dev/get-started/install))
- A connected device or emulator

### Installation

```bash
git clone https://github.com/zeeshanleghari/beautymart-flutter-app.git
cd beautymart-flutter-app
flutter pub get
flutter run
```

## API Reference

This project uses the free [DummyJSON Products API](https://dummyjson.com/products):

| Endpoint | Description |
|---|---|
| `GET /products` | Fetch all products |
| `GET /products/category-list` | Fetch list of categories |
| `GET /products/category/{category}` | Fetch products by category |

## What I Learned

The biggest takeaway from this project was working with the **http package** in Flutter — making GET requests, decoding JSON responses, and structuring the data flow so the UI updates correctly with `setState`. I also ran into and fixed a few Flutter layout quirks (like `ListTile` sizing issues) along the way, which helped me better understand widget constraints and intrinsic sizing.

## Future Improvements

- [ ] Implement working search functionality
- [ ] Add persistent cart storage (local database)
- [ ] Add quantity selector in cart
- [ ] Add user authentication
- [ ] Add checkout flow

Built with ❤️ using Flutter
