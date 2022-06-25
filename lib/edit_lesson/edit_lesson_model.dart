import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osakalivetheater3/domain/lesson.dart';

class EditLessonModel extends ChangeNotifier {
  final lesson;
  EditLessonModel(this.lesson){
    techController.text=lesson.tech;
    stageController.text=lesson.stage;
  }

  final techController = TextEditingController();
  final stageController = TextEditingController();

  String? Tech;
  String? Stage;

  void setTech(String Tech){
    this.Tech = Tech;//画面上のTechをTechとして認識
    notifyListeners();
  }

  void setStage(String Stage){
    this.Stage = Stage;//画面上のStageをStageとして認識
    notifyListeners();
  }


  bool isUpdated(){
    return Tech !=null || Stage != null;
  }

  Future update() async{

    this.Tech=techController.text;
    this.Stage=stageController.text;

    //firestoreに追加
    await FirebaseFirestore.instance.collection('lessons').doc(lesson.id).update({
      'tech': Tech,//画面上のTechをtechとして入力
      'stage': Stage,//画面上のStageをstageとして入力
    });
  }
}