import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osakalivetheater3/domain/lesson.dart';
import 'package:osakalivetheater3/lesson_list/lesson_list_model.dart';

class EditLessonModel extends ChangeNotifier {
  final Lesson lesson;
  EditLessonModel(this.lesson){
    techController.text=lesson.tech;
    stageController.text=lesson.stage;
  }

  final techController = TextEditingController();
  final stageController = TextEditingController();

  String? tech;
  String? stage;

  void setTech(String tech){
    this.tech = tech;//画面上のTechをTechとして認識
    notifyListeners();
  }

  void setStage(String Stage){
    this.stage = Stage;//画面上のStageをStageとして認識
    notifyListeners();
  }


  bool isUpdated(){
    return tech !=null || stage != null;
  }

  Future update() async{

    this.tech=techController.text;
    this.stage=stageController.text;

    //firestoreに追加
    await FirebaseFirestore.instance.collection('lessons').doc(lesson.id).update({
      'tech': tech,//画面上のTechをtechとして入力
      'stage': stage,//画面上のStageをstageとして入力
    });
  }
}