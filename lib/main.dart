import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    ));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkedAnswer(bool userPikedAnswer) {
    bool questionAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          buttons: <DialogButton>[],
          style: AlertStyle(
            titleStyle: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: 'Museo Moderno',
              fontWeight: FontWeight.bold,
            ),
            descStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Museo Moderno',
            ),
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                color: Colors.grey.shade100,
                width: 5.0,
              ),
            ),
            backgroundColor: Colors.grey[900],
            isCloseButton: false,
          ),
        ).show();

        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userPikedAnswer == questionAnswer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Museo Moderno',
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: RawMaterialButton(
              fillColor: Colors.green,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green.shade100,
                      width: 5.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'True',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Museo Moderno',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  )),
              onPressed: () {
                checkedAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: RawMaterialButton(
              fillColor: Colors.red,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red.shade100,
                      width: 5.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'False',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Museo Moderno',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  )),
              onPressed: () {
                checkedAnswer(false);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
