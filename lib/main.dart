import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/comment.dart';
import 'screens/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CommentProvide(),
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
      home: const HomeScreen(),
    );
  }
}
