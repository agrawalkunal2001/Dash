import 'package:dash/features/auth/view/signup_view.dart';
import 'package:dash/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dash',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const SignUpView(),
    );
  }
}
