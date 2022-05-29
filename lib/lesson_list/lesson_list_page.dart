import 'package:osakalivetheater3/domain/lesson.dart';
import 'package:flutter/material.dart';
import 'package:osakalivetheater3/lesson_list/lesson_list_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LessonListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LessonListModel>(
        create: (_) => LessonListModel()..fetchLessonList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('テクニック一覧'),
        ),
        body: Center(
          child:Consumer<LessonListModel>(builder: (context, model, child) {
            final List<lesson>? lessons = model.lessons;

            if(lessons == null){
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = lessons
                .map(
                  (lessons)=>ListTile(
                    title:Text(lessons.tech),
                    subtitle:Text(lessons.stage),
                  ),
            )
            .toList();
            return ListView(
            children: widgets,
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}