import 'package:flutter/material.dart';
import 'package:osakalivetheater3/add_lesson/add_lesson_page.dart';
import 'package:osakalivetheater3/lesson_list/lesson_list_model.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osakalivetheater3/domain/lesson.dart';


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
            final List<Lesson>? lessons = model.lessons;

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
          floatingActionButton:
            Consumer<LessonListModel>(builder:(content,model,child){
              return FloatingActionButton(
                onPressed: () async {
                  //画面遷移
                final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLessonPage(),
                    fullscreenDialog: true,
                  ),
                );

                if(added !=null && added){
                  final snackBar = SnackBar(
                      backgroundColor:Colors.green,
                       content:Text('レッスンを追加しました'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                model.fetchLessonList();
                },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            );
          }),
      ),
    );
  }
}