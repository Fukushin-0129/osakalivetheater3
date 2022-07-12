import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddLessonModel extends ChangeNotifier {
  String? tech;
  String? stage;
  File? imageFile;
  bool isLoading=false;

  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future addLesson() async{
    if (tech == null || tech == ""){
      throw '技術のタイトルが入力されていません';
    }

    if (stage == null || stage!.isEmpty){
      throw 'ステージのタイトルが入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('lessons').doc();

    String? imgURL;
    if(imageFile !=null) {
      //storageにアップロード
      final task= await FirebaseStorage.instance
          .ref('lessons/${doc.id}')
          .putFile(imageFile!);
    imgURL=await task.ref.getDownloadURL();
    }
      //firestoreに追加
      await doc.set({
        'tech': tech,
        'stage': stage,
        'imgURL':imgURL,
      });
    }

    Future pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
   }
  }
}