# 📚 Bookly App

[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Vhmmed/Bookly_App)

Bookly is a Flutter mobile application designed for discovering, browsing, and exploring books using the **Google Books API**.  
It provides a clean, modern UI with smooth navigation, powerful search, and curated book sections like “Best Sellers” and “Featured Books”.

---

## 🚀 Features

- ✅ **Discover Books**  
  Explore featured books and trending best sellers.

- ✅ **Detailed Book Information**  
  View book details including cover, authors, rating, description, preview links, etc.

- ✅ **Advanced Search**  
  Find books instantly using titles, keywords, or subjects.

- ✅ **Shopping Cart**  
  Add books, calculate total price, and manage cart items.

- ✅ **Similar Books**  
  Get related book suggestions based on category/genre.

- ✅ **Modern UI**  
  Smooth, responsive, and dark-themed user interface built with Flutter.

---

## 🏗️ Tech Stack

This project follows **Feature-Driven Clean Architecture** for scalability and clean code.

- **Framework:** Flutter  
- **State Management:** Flutter BLoC (Cubit)  
- **Navigation:** GoRouter  
- **HTTP Client:** Dio  
- **Dependency Injection:** GetIt  
- **Error Handling:** Either (Dartz)  
- **Caching:** CachedNetworkImage  
- **Architecture Layers:**
  - `presentation/`
  - `manager/`
  - `data/`

---

## 📂 Project Structure

  lib/
  ├── core/              # Shared resources: router, DI, API service, styles
  ├── feature/
  │   ├── home/          # Home, book details, cart
  │   │   ├── data/
  │   │   ├── manager/
  │   │   └── presentation/
  │   ├── search/        # Search screen + logic
  │   └── splash/        # Splash screen
  └── main.dart          # App entry point + DI setup

---

## 🚀 Getting Started

Follow the steps below to run the app locally.

### ✅ Prerequisites

- Install Flutter:  
  https://flutter.dev/docs/get-started/install

### ✅ Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/vhmmed/bookly_app.git

2.	Navigate to the project:

  	    cd bookly_app

3.	Install dependencies:

        flutter pub get

4.	Run the app:

        flutter run

📸 Screenshots

|   Home Screen  |   Splash Screen   | Products |
|----------------|-------------------|----------|
| <img src="core/images/HomeScreen.png" width="200"> | <img src="core/images/splash.png" width="200"> | <img src="core/images/cartwithbooks.png" width="200"> |

|    Cart    | Cart Book | Details |
|------------|-----------|----------|
| <img src="core/images/Cart.png" width="200"> | <img src="core/images/payment.png" width="200"> | <img src="assets/images/screenshots/bookdatalis.png" width="200"> |


🤝 Contributing

Pull Requests are welcome.
For major changes, please open an issue first to discuss what you would like to improve.

⸻

📜 License

This project is licensed under the MIT License — feel free to modify and use it.

⸻

👤 Author

Ahmed Adel
Flutter Developer


