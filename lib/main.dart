import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/constants.dart';
import 'package:store_app/helper/api.dart';
import 'package:store_app/theme.dart';
import 'package:store_app/views/home_view.dart';
import 'package:store_app/views/login_view.dart';
import 'package:store_app/views/update_product_view.dart';
import 'package:store_app/widgets/bottom_navigation.dart';

// class AppRoutes {
//   static const String home = '/';
//   static const String updateProduct = '/update-product';
//   static const String login = '/login';
//   // Add more routes as needed
// }

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(),
      home: NavigationContainer(),
      routes: {
        // HomeView.id: (context) => HomeView(),
        UpdateProductView.id: (context) => UpdateProductView(),
        // LoginView.id: (context) => LoginView(),
        LoginView.id: (context) => LoginView(),
      },
      initialRoute: HomeView.id,
    );
  }
}
