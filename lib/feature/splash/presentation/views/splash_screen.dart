import 'package:bookly_app/feature/splash/presentation/views/widget/splash_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashBody();
  }
}


void navigateToHome(BuildContext context) {
  Future.delayed(
    const Duration(seconds: 3),
        () {
      GoRouter.of(context).go('/homeScreen');
    },
  );
}