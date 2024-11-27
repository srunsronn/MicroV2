import 'package:flutter/material.dart';
import 'package:microquiz2/model/quiz.dart'; // Ensure this contains your `Question` model.
import 'package:microquiz2/widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;
  final List<Question> questions;
  final Map<Question, String> userAnswers; // Map of user-selected answers.

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.onRestart,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "You answered $score on $total !",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              for (var i = 0; i < questions.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center all children
                    children: [
                      // Align the CircleAvatar and Question Text together
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // Center the Row
                        children: [
                          // Question index with CircleAvatar
                          CircleAvatar(
                            backgroundColor: userAnswers[questions[i]] ==
                                    questions[i].goodAnswer
                                ? Colors.green
                                : Colors.red,
                            radius: 20,
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Question title (Text)
                          Flexible(
                            // Use Flexible to allow dynamic sizing
                            child: Text(
                              questions[i].title,
                              textAlign:
                                  TextAlign.center, // Center the question title
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Display possible answers with proper formatting
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // Center align answers
                        children: questions[i].possibleAnswers.map((option) {
                          final isCorrect = option == questions[i].goodAnswer;
                          final isUserAnswer =
                              option == userAnswers[questions[i]];

                          return Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center the answer options
                            children: [
                              Icon(
                                isUserAnswer
                                    ? (isCorrect
                                        ? Icons.check_circle
                                        : Icons.cancel)
                                    : (isCorrect
                                        ? Icons.check_circle_outline
                                        : null),
                                color: isCorrect
                                    ? Colors.green
                                    : (isUserAnswer ? Colors.red : Colors.grey),
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                option,
                                style: TextStyle(
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
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              // Restart Button
              AppButton(
                "Restart Quiz",
                onTap: onRestart,
                icon: Icons.restart_alt_sharp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
