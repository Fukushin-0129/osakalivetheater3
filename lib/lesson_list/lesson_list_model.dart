import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osakalivetheater3/domain/lesson.dart';

class LessonListModel extends ChangeNotifier {
  List<lesson>? lessons;

  void fetchLessonList() async{
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('lessons').get();

    final List<lesson> lessons = snapshot.docs.map((
        DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String tech = data['tech'];
      final String stage = data['stage'];
      return lesson(id,stage, tech);
    }).toList();

      this.lessons = lessons;
      notifyListeners();
  }

  Future delete(lesson lesson){
    return FirebaseFirestore.instance.collection('lessons').doc(lesson.id).delete();
  }
}