import 'package:flutter/material.dart';
import 'features/search/views/search_page.dart';
import 'core/di/injection.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Company Detail',
      theme: ThemeData.light(),
      home: const SearchPage(),
    );
  }
}
