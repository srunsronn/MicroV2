import 'package:flutter/material.dart';
import 'package:microquiz2/model/quiz.dart';
import 'package:microquiz2/model/submission.dart';
import 'package:microquiz2/screens/question_screen.dart';
import 'package:microquiz2/screens/result_screen.dart';
import 'package:microquiz2/screens/welcome_screen.dart';

enum QuizState { notStarted, started, finished }

Color appColor = Colors.blue[500]!;

class QuizApp extends StatefulWidget {
  final Quiz quiz;

  const QuizApp(this.quiz, {super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState _quizState = QuizState.notStarted;
  late Quiz quiz;
  int _currentQuestionIndex = 0;
  final Submission _submission = Submission();

  @override
  void initState() {
    super.initState();
    quiz = widget.quiz;
  }

  void _startQuiz() {
    setState(() { 
      _quizState = QuizState.started;
      _currentQuestionIndex = 0;
      _submission.removeAnswers();
    });
  }

  void _answerQuestion(String selectedAnswer) {
    Question currentQuestion = quiz.questions[_currentQuestionIndex];
    _submission.addAnswer(currentQuestion, selectedAnswer);

    if (_currentQuestionIndex + 1 < quiz.questions.length) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _quizState = QuizState.finished;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _quizState = QuizState.notStarted;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;

    switch (_quizState) {
      case QuizState.notStarted:
        screen = WelcomeScreen(
          onStart: _startQuiz,
          title: quiz.title,
        );
        break;
      case QuizState.started:
        screen = QuestionScreen(
          question: quiz.questions[_currentQuestionIndex],
          onTap: _answerQuestion,
        );
        break;
      case QuizState.finished:
        screen = ResultScreen(
          onRestart: _restartQuiz,
          quiz: quiz,
          submission: _submission,
        );
        break;
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: appColor,
        body: screen,
      ),
    );
  }
}
