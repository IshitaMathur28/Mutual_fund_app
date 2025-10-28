# Mutual Fund Mobile App

Features
 Fund Performance Visualization — Interactive graphs for 1Y, 3Y, and 5Y returns
 Favorites Management — Add or remove schemes from your favorite list using GetX
 Fund Search & Details — View detailed information about each scheme
 Modern UI — Clean and responsive interface using Flutter Material Design
 State Management — Built with GetX for efficient and reactive state control

 Tech Stack
Framework: Flutter
Language: Dart
State Management: GetX

Project Structure
lib/

 ├── controller/
 
 │    └── favourites.dart
 │    ├── nav_controller.dart
 │    ├── scheme_controller.dart      
 ├── model/
 │    └── nav_entry.dart
      └── scheme.dart
 ├── screens/
 │    ├── home_screen.dart
 │    ├── detail_screen.dart
 │    └── favorites_screen.dart
 ├── widgets/
 │    └── fund_tile.dart
 │    └── nav_chart.dart
 ├── services/
 │    ├── service.dart
 └── main.dart
