import 'dart:async';
import 'package:do_an/models/load_data.dart';
import 'package:quiver/pattern.dart';
import 'dart:math';
import 'package:do_an/widgets/result_box.dart';
import 'package:do_an/widgets/time_out.dart';
import 'package:flutter/material.dart';
import '../prefer.dart';

class Answer extends StatefulWidget {
  List<Question> data;

  int id_chude;
  Answer({
    Key? key,
    required this.data,
    required this.id_chude,
  }) : super(key: key);

  @override
  State<Answer> createState() => AnswerState();
}

class AnswerState extends State<Answer> {
  late int _current;
  late Timer _time;
  int current_index = 0;
  String selectAnswer = '';
  int diem = 0;
  int? id_chude;
  var answer_0 = Colors.white;
  var answer_1 = Colors.white;
  var answer_2 = Colors.white;
  var answer_3 = Colors.white;

  void NextQuestion() {
    Future.delayed(Duration(milliseconds: 200), () {
      if (current_index == questions.length - 1) {
        _time.cancel();

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) {
              return ResultBox(
                result: diem,
                question_lenght: questions.length,
                playAgain: startAgain,
              );
            });
      }

      setState(() {
        if (current_index == questions.length - 1) return;
        current_index++;
        selectAnswer = '';
        _current = 20;
      });
    });
  }
  // int diem = 0;

  // void startTimer() {
  //   CountdownTimer countDownTimer = new CountdownTimer(
  //     new Duration(seconds: _start),
  //     new Duration(seconds: 1),
  //   );

  //   var sub = countDownTimer.listen(null);
  //   sub.onData((duration) {
  //
  //   });

  //   sub.onDone(() {
  //     sub.cancel();
  //   });
  // }

  List<Question> questions = [];

  void _LoadQuestion() async {
    //var data = await Question.GetAll(id_chude!);
    setState(() {});
    questions = widget.data;
  }

  @override
  void initState() {
    super.initState();
    id_chude = this.widget.id_chude;
    _LoadQuestion();
    
    
    _current = 20;
    _time = Timer.periodic(Duration(seconds: 1), (timer) {
      print(_current);
      setState(() {
        _current -= 1;
      });
      if (_current == 0) {
        _time.cancel();
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (ctx) {
        //       return TimeOutBox(
        //         result: diem,
        //         question_lenght: widget.questions.length,
        //         playAgain: startAgain,
        //       );
        //     });
      }
    });
  }

  void startAgain() {
    _current = 20;
    _time = Timer.periodic(Duration(seconds: 1), (timer) {
      print(_current);
      setState(() {
        _current -= 1;
      });
      if (_current == 0) {
        _time.cancel();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) {
              return TimeOutBox(
                result: diem,
                question_lenght: questions.length,
                playAgain: startAgain,
              );
            });
      }
    });
    setState(() {
      current_index = 0;
      selectAnswer = '';
      diem = 0;
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _time.cancel();
    super.dispose();
  }

  // List<String> randomAnswer(Question ques) {
  //   List<int> randNum = [0, 1, 2, 3];

  //   List<String> temp = [];

  //   temp.add(ques.option_true!);
  //   temp.add(ques.option_false_1!);
  //   temp.add(ques.option_false_2!);
  //   temp.add(ques.option_false_3!);

  //   List<String> answer = [];

  //   int x = randNum.length;

  //   for (int i = 0; i < x; i++) {
  //     int randValue = randNum[Random().nextInt(randNum.length - 0)];
  //     answer.add(temp[randValue]);
  //     randNum.remove(randValue);
  //   }

  //   return answer;
  // }

  @override
  Widget build(BuildContext context) {

    Question current_question = questions[current_index];
    final List<String> answer = randomAnswer(questions[current_index]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfffcbf49),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(9),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${Prefer.getPicture()}'),
                ),
              ),

              //Tên username
              Container(
                margin: EdgeInsets.only(right: 2, left: 2),
                child: Text(
                  '${Prefer.getName()}',
                  style: TextStyle(
                      fontSize: 20, color: Colors.red, fontFamily: 'Lalezar'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 80, right: 5),
                width: 40,
                height: 40,
                child: Image.asset('images/dollar.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: 1, right: 9),
                child: Text(
                  '${Prefer.getCredit()}',
                  style: TextStyle(
                      fontFamily: 'Lalezar', fontSize: 23, color: Colors.red),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          SizedBox(
            width: 330,
            height: 25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    color: Colors.green,
                    value: _current / 20,
                  ),
                  Center(
                    child: Text(
                      _current.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Số câu',
                      style: TextStyle(fontSize: 25, color: Color(0xff032f4c)),
                    ),
                    Text(
                      '${current_index + 1}/${questions.length}',
                      style: TextStyle(fontSize: 25, color: Color(0xff032f4c)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Điểm',
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    ),
                    Text(
                      '$diem',
                      style: TextStyle(fontSize: 25, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            height: 120,
            width: 6000,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: //Text('${Question.question}'),

                Text(
              '${current_question.question}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //       return Text(index.toString());
          //     },
          //     itemCount: current_question.answer.length,
          //   ),
          // ),
          Expanded(
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // color: (selectAnswer == current_question &&
                  //         answers == current_question.correct_answer)
                  //     ? Colors.green
                  //     : (selectAnswer == answers &&
                  //             answers != current_question.correct_answer)
                  //         ? Colors.red
                  //         : null,
                  child: ListTile(
                    onTap: () {
                      if(current_question.answer[0] == current_question.option_true){
                        setState(() {
                          answer_0 = Colors.green;
                        });
                        NextQuestion();
                        
                      } else{
                        setState(() {
                          answer_0 = Colors.red;
                        });
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) {
                            return TimeOutBox(
                              result: diem,
                              question_lenght: questions.length,
                              playAgain: startAgain,
                            );
                          });
                      }
                    },
                    title: Text(
                      '${current_question.answer[0]}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    //padding: EdgeInsets.all(10),
                  ),
                  color: answer_0
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    //padding: EdgeInsets.all(10),
                    title: Text(
                      '${current_question.answer[1]}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      if(current_question.answer[1] == current_question.option_true){
                        setState(() {
                          answer_1 = Colors.green;
                        });
                        NextQuestion();
                      } else{
                        setState(() {
                          answer_1 = Colors.red;
                        });
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) {
                            return TimeOutBox(
                              result: diem,
                              question_lenght: questions.length,
                              playAgain: startAgain,
                            );
                          });
                      }
                    },
                  ),
                  color: answer_1
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    //  padding: EdgeInsets.all(10),
                    title: Text(
                      '${current_question.answer[2]}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      if(current_question.answer[2] == current_question.option_true){
                        setState(() {
                          answer_2 = Colors.green;
                        });
                        NextQuestion();
                      } else{
                        setState(() {
                          answer_2 = Colors.red;
                        });
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) {
                            return TimeOutBox(
                              result: diem,
                              question_lenght: questions.length,
                              playAgain: startAgain,
                            );
                          });
                      }
                    },
                  ),
                  color: answer_2
                ),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    //padding: EdgeInsets.all(10),
                    title: Text(
                      '${current_question.answer[3]}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: () {
                      if(current_question.answer[3] == current_question.option_true){
                        setState(() {
                          answer_3 = Colors.green;
                        });
                        NextQuestion();
                      } else{
                        setState(() {
                          answer_3 = Colors.red;
                        });
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) {
                            return TimeOutBox(
                              result: diem,
                              question_lenght: questions.length,
                              playAgain: startAgain,
                            );
                          });
                      }
                    },
                  ),
                  color: answer_3
                ),

                // Card(
                //   margin: EdgeInsets.only(top: 8, left: 15, right: 15),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20),
                //   ),

                //child:

                // ListTile(
                //   onTap: () {
                //     setState(() {
                //       current_index++;
                //     });
                //   },
                //   title: Text(
                //     '${Question.answer}',
                //   ),
                // ),
                // color: (selectAnswer == answers &&
                //         answers == current_question.correct_answer)
                //     ? Colors.green
                //     : (selectAnswer == answers &&
                //             answers != current_question.correct_answer)
                //         ? Colors.red
                //         : null,
                // child: ListTile(
                //   onTap: () {
                //     setState(() {
                //       selectAnswer = answers;
                //     });
                //     if (answers == current_question.correct_answer) {
                //       diem += 10;
                //     }
                //     NextQuestion();
                //   },
                //   title: Text(
                //     answers,
                //     style: TextStyle(
                //       color: selectAnswer == answers
                //           ? Colors.white
                //           : Colors.black,
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
                // )

                // child: ListView.builder(
                //   itemBuilder: (context, index) {
                //     final answers = current_question.answer[index];
                //     return Card(
                //       margin: EdgeInsets.only(top: 8, left: 15, right: 15),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //       color: (selectAnswer == answers &&
                //               answers == current_question.correct_answer)
                //           ? Colors.green
                //           : (selectAnswer == answers &&
                //                   answers != current_question.correct_answer)
                //               ? Colors.red
                //               : null,
                //       child: ListTile(
                //         onTap: () {
                //           setState(() {
                //             selectAnswer = answers;
                //           });
                //           if (answers == current_question.correct_answer) {
                //             diem += 10;
                //           }
                //           NextQuestion();
                //         },
                //         title: Text(
                //           answers,
                //           style: TextStyle(
                //             color: selectAnswer == answers
                //                 ? Colors.white
                //                 : Colors.black,
                //             fontSize: 20,
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                //   itemCount: current_question.answer.length,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
