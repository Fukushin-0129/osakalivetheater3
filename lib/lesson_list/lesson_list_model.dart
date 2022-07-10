import 'package:osakalivetheater3/domain/lesson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LessonListModel extends ChangeNotifier {
  List<Lesson>? lessons;

  void fetchLessonList() async{
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('lessons').get();

    final List<Lesson> lessons = snapshot.docs.map((
        DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String tech = data['tech'];
      final String stage = data['stage'];
      return Lesson(id, stage, tech);
    }).toList();

      this.lessons = lessons;
      notifyListeners();
  }

    Future delete(Lesson lesson){
    return FirebaseFirestore.instance.collection('lessons').doc(lesson.id).delete();
  }
}