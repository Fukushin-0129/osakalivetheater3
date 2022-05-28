import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {

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
                  (lesson)=>ListTile(
                    tech:Text(lesson.tech),
                    stage:Text(lesson.stage),
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