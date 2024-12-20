import 'package:flutter/material.dart';
import 'package:project_f/bottom_navigation_bar.dart';
import 'package:project_f/product_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductManager()..loadProducts(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 239, 239, 238),
        ),
        home: const BottomNavWithAnimatedIcons());
  }
}
