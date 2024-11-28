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
              ...quiz.questions.asMap().entries.map((entry) {
                int index = entry.key;
                Question question = entry.value;

                final userAnswer =
                    submission.getAnswerFor(question)?.selectAnswer;
                final isCorrect =
                    userAnswer != null && userAnswer == question.goodAnswer;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: isCorrect
                              ? Colors.green 
                              : Colors.red, 
                          child: Text(
                            '${index + 1}', 
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            question.title,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Display the answers for the question
                    ...question.possibleAnswers.map((answer) {
                      final isCorrectAnswer = answer == question.goodAnswer;
                      final isUserAnswer = userAnswer == answer;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 40), 
                            Icon(
                              isCorrectAnswer
                                  ? Icons.check_circle 
                                  : (isUserAnswer
                                      ? Icons.cancel 
                                      : Icons.circle_outlined),
                              color: isCorrectAnswer
                                  ? Colors.green
                                  : (isUserAnswer ? Colors.red : Colors.grey),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              answer,
                              style: TextStyle(
                                fontSize: 18,
                                color: isCorrectAnswer
                                    ? Colors.green
                                    : (isUserAnswer
                                        ? Colors.red
                                        : Colors.black),
                                fontWeight: isCorrectAnswer || isUserAnswer
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
                );
              }),
              const SizedBox(height: 30),
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
