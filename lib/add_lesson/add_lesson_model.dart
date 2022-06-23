import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddLessonModel extends ChangeNotifier {
  String? tech;
  String? stage;

  Future addLesson() async{
    if (tech == null || tech == ""){
      throw '技術のタイトルが入力されていません';
    }

    if (stage == null || stage!.isEmpty){
      throw 'ステージのタイトルが入力されていません';
    }

      //firestoreに追加
      await FirebaseFirestore.instance.collection('Lessons').add({
        'tech': tech,
        'stage': stage,
      });
    }
  }