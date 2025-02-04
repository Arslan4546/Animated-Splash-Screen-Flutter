import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _rotationController =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();

  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..forward();

  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 0.0, // Small size at start
    end: 1.0, // Normal size
  ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/images/Splash_screen.png"), // ✅ Background Image Fix
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _rotationController,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                    "assets/images/recipe2.png"), // ✅ Fixed Image Widget
              ),
            ),
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value *
                    2.0 *
                    math.pi, // ✅ Corrected Rotation
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
