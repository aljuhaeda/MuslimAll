import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'view/homepage.dart';

void main() {
  runApp(const MuslimAllApp());
}

class MuslimAllApp extends StatelessWidget {
  const MuslimAllApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MuslimAll',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
