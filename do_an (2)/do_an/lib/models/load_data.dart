import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class Question {
  static var _question = FirebaseFirestore.instance.collection("questions");

  String? question, option_true;
  List<String> answer = [];

  //Question(this.question)

  static Question? ques;

  static Future<List<Question>> GetAll(int id_chude) async {
    List<Question> lsQuest = [];
    await _question.where('id_chude', isEqualTo: id_chude).get().then((value) {
      for (var i in value.docs) {
        Question ques = new Question();
        ques.question = i.data()["question"];
        ques.answer.add(i.data()["option_true"]);
        ques.answer.add(i.data()["option_false_1"]);
        ques.answer.add(i.data()["option_false_2"]);
        ques.answer.add(i.data()["option_false_3"]);
        ques.option_true = i.data()["option_true"];

        ques.answer = randomAnswer(ques);

        //print('--------------------------${ques.question}');

        lsQuest.add(ques);
      }
    });

    //print('--------------------------${lsQuest[0].option_true}');

    return lsQuest;
  }
}

List<String> randomAnswer(Question ques) {
    List<int> randNum = [0, 1, 2, 3];

    List<String> temp = [];

    temp.add(ques.answer[0]);
    temp.add(ques.answer[1]);
    temp.add(ques.answer[2]);
    temp.add(ques.answer[3]);

    List<String> answer = [];

    int x = randNum.length;

    for (int i = 0; i < x; i++) {
      int randValue = randNum[Random().nextInt(randNum.length - 0)];
      answer.add(temp[randValue]);
      randNum.remove(randValue);
    }

    return answer;
  }