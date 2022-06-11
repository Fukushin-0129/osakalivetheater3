import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/lesson.dart';

class EditLessonModel extends ChangeNotifier {
  final Lesson lesson;
  EditLessonModel(this.lesson){
    techController.text=lesson.tech;
    stageController.text=lesson.stage;
  }

  final techController = TextEditingController();
  final stageController = TextEditingController();

  String? Tech;
  String? Stage;

  void setTech(String Tech){
    this.Tech = Tech;
    notifyListeners();
  }

  void setStage(String Stage){
    this.Stage = Stage;
    notifyListeners();
  }


  bool isUpdated(){
    return Tech !=null || Stage != null;
  }

  Future update() async{

    this.Tech=techController.text;
    this.Stage=stageController.text;

    //firestoreに追加
    await FirebaseFirestore.instance.collection('Lessons').doc(lesson.id).update({
      'Tech': Tech,
      'Stage': Stage,
    });
  }
}