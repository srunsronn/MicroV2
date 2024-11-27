import 'package:flutter/material.dart';
import 'package:microquiz2/quiz_app.dart';
import 'package:microquiz2/widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  VoidCallback onStart;
  final String title;
  WelcomeScreen({super.key, required this.onStart, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/quiz-logo.png",
              height: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            AppButton(
              "Start Quiz",
              onTap: onStart,
              icon: Icons.arrow_right_alt_sharp,
            )
          ],
        ),
      ),
    );
  }
}
