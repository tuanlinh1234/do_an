import 'package:do_an/prefer.dart';
import 'package:do_an/screen/data/data_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NapThe {
  void Nap(int sonap ,context) async {
    final QuerySnapshot result = await FirebaseFirestore.instance.collection('users')
    .where('email', isEqualTo: Prefer.getMail()).get();

    final List <DocumentSnapshot> documents = result.docs;

    if (documents.length > 0) {

      result.docs.forEach((doc) {
        doc.reference.update({'credit' : int.parse(Prefer.getCredit()) + sonap});
      });

      DataUser.getAll(Prefer.getMail());
showDialog(
      context: context,
      builder: (ctx){
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Nạp thành công !'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx),
              child: Text('OK')
            )
          ],
        );
      }
    );
    }
  }
}
