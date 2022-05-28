import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osakalivetheater3/domain/lesson.dart';

class LessonListModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('lessons').snapshots();

  List<Lesson>? lessons;

  void fetchLessonList() {
    _usersStream.listen((QuerySnapshot snapshot) {
      final List<Lesson> lessons = snapshot.docs.map((
          DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String tech = data['tech'];
        final String stage = data['stage'];
        return Lesson(stage, tech);
      }).toList();

      this.lessons = lessons;
      notifyListeners();
    });
  }
}