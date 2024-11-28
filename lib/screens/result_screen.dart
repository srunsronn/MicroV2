import 'package:flutter/material.dart';
import 'package:microquiz2/model/quiz.dart';
import 'package:microquiz2/model/submission.dart';
import 'package:microquiz2/widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.onRestart,
    required this.quiz,
    required this.submission,
  });

  final VoidCallback onRestart;
  final Quiz quiz;
  final Submission submission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the score
              Text(
                'You scored ${submission.getScore()} out of ${quiz.questions.length}!',
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ...quiz.questions.map((item) => Column(
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...item.possibleAnswers.map((answer) {
                        final isCorrect = answer == item.goodAnswer;
                        final userAnswer =
                            submission.getAnswerFor(item)?.selectAnswer;
                        final isUserAnswer = userAnswer == answer;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isCorrect
                                    ? Icons.check_circle
                                    : (isUserAnswer
                                        ? Icons.cancel
                                        : Icons.circle_outlined),
                                color: isCorrect
                                    ? Colors.green
                                    : (isUserAnswer ? Colors.red : Colors.grey),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                answer,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: isCorrect
                                      ? Colors.green
                                      : (isUserAnswer
                                          ? Colors.red
                                          : Colors.black),
                                  fontWeight: isCorrect || isUserAnswer
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                    ],
                  )),
              const SizedBox(height: 30),
              // Restart button
              AppButton(
                "Restart Quiz",
                onTap: onRestart,
                icon: Icons.restart_alt_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
