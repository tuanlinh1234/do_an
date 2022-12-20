import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../prefer.dart';

class DataUser{
static var _userTable = FirebaseFirestore.instance.collection("users");
static String? mail, name, birth, phone, pic;
static int? credit, highestPoint;

  static getAll(String email) async{
    _userTable.where('email', isEqualTo: email).get().then((value) {
      for(var a in value.docs){
        mail = a.data()["email"];
        name = a.data()["name"];
        birth = a.data()["birthDate"];
        phone = a.data()["phone"];
        pic = a.data()["photoUrl"];
        credit = a.data()["credit"];
        highestPoint = a.data()["highestPoint"];

        Prefer.setBirthDate(birthdate: birth!);
        Prefer.setName(name: name!);
        Prefer.setPhone(phone: phone!);
        Prefer.setMail(mail: mail!);
        Prefer.setPicture(picture: pic!);
        Prefer.setCredit(credit: credit!.toString());
        Prefer.setScore(score: highestPoint!.toString());
        //print('-----------------------${Prefer.getScore()}');
      }
    });
  }
}