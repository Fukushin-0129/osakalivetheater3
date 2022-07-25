import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  final techController = TextEditingController();
  final stageController = TextEditingController();

  String? email;
  String? password;

  void setEmail(String email){
    this.email = email;//画面上のTechをTechとして認識
    notifyListeners();
  }

  void setPassword(String password){
    this.password = password;//画面上のStageをStageとして認識
    notifyListeners();
  }

  Future signup() async{
    this.email=techController.text;
    this.password=stageController.text;

    //firebase authでユーザー作成


    //firestoreに追加
    //await FirebaseFirestore.instance.collection('lessons').doc(lesson.id).update({
    //  'tech': email,//画面上のTechをtechとして入力
    //  'stage': password,//画面上のStageをstageとして入力
    //});
  }
}