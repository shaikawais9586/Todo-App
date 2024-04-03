import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Get.off(() => const MyHomePage());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
              text: const TextSpan(
                  style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(text: 'What '),
                    TextSpan(
                      text: 'TODO?',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    )
                  ]),
            ),
            Image.asset('assets/images/image.png')
          ],
        ),
      ),
    );
  }
}
