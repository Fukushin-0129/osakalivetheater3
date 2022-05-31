import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddLessonModel extends ChangeNotifier {
  String? Tech;
  String? Stage;

  Future addLesson() async{
    if (Tech == null || Tech == ""){
      throw '技術のタイトルが入力されていません';
    }

    if (Stage == null || Stage!.isEmpty)
      throw 'ステージのタイトルが入力されていません';
    }

      //firestoreに追加
      await FirebaseFirestore.instance.collection('Lessons').add({
        'Tech': Tech,
        'Stage': Stage,
      });
    }
  }