//class Answer
import 'package:flutter/material.dart';
import 'package:microquiz2/model/quiz.dart';

class Answer {
  Question question;
  String selectAnswer;

  Answer(this.selectAnswer, this.question);

  bool isCorrect() {
    return selectAnswer.contains(question.goodAnswer) &&
        question.goodAnswer.contains(selectAnswer);
  }
}

// class Submission
class Submission {

  List<Answer> answers = [];

  //calculate score
  int getScore() {
    int totalScore = 0;

    for (var answer in answers) {
      if (answer.isCorrect()) {
        totalScore++;
      }
    }

    return totalScore;
  }

  //add answer
  void addAnswer(Question questions, String answer) {
    answers.add(Answer(answer, questions));
  }

  // get answer
  Answer? getAnswerFor(Question question) {
    for (var answer in answers) {
      if (answer.question == question) {
        return answer;
      }
    }
    return null;
  }
  Map<Question, String> getUserAnswers() {
  return {for (var answer in answers) answer.question: answer.selectAnswer};
}

  // remove Answer
  void removeAnswers() {
    answers.clear();
  }
}

// void main() {
//   Question question1 = Question(
//       title: "what is 2+2?", possibleAnswers: ["2", "4", "5"], goodAnswer: "4");
//   Question question2 = Question(
//       title: "what is 3+2?", possibleAnswers: ["2", "4", "5"], goodAnswer: "5");

//   Submission submission = Submission();

//   submission.addAnswer(question1, "4");
//   submission.addAnswer(question2, "4");

//   print(
//       "Answer for quest1 is correct: ${submission.getAnswerFor(question1)?.isCorrect()}");
//   print(
//       "Answer for quest2 is correct: ${submission.getAnswerFor(question2)?.isCorrect()}");

//   print("Total score: ${submission.getScore()}");

//   submission.addAnswer(question2, "5");
//   print("Total score: ${submission.getScore()}");

//   submission.removeAnswers();
//   print("Answers removed. Total score: ${submission.getScore()}");
// }
