import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:osakalivetheater3/add_lesson/add_lesson_page.dart';
import 'package:osakalivetheater3/lesson_list/lesson_list_model.dart';
import 'package:provider/provider.dart';
import 'package:osakalivetheater3/domain/lesson.dart';
import '../edit_lesson/edit_lesson_page.dart';

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

            if(lessons == null){return CircularProgressIndicator();}
            final List<Widget> widgets = lessons.map((lessons) =>
                Slidable(endActionPane: ActionPane(motion: DrawerMotion(),
                  children: [
                  SlidableAction(onPressed: (value) async {//画面遷移
                    final String? title = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditLessonPage(lessons),),);
                    if (title != null) {
                      final snackBar = SnackBar(backgroundColor: Colors.green, content: Text('$titleを編集しました'),);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);}
                    model.fetchLessonList();},
                    backgroundColor: Colors.black45,
                     icon: Icons.edit,
                    label: '編集',
                    ),

                    SlidableAction(
                      onPressed: (BuildContext context)async {
                        // 削除しますか？って聞いて、はいだったら削除
                        await showConfirmDialog(context, lessons, model);
                      },
                        backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: '削除',
                      ),
                    ],
                    ),

                    child: ListTile(
                        title: Text(lessons.tech),
                         subtitle: Text(lessons.stage),
                    ) ,
                      ),
                         )
                  .toList();
                    return ListView(
                    children: widgets,
                    );
                    }),
                     ),

              floatingActionButton:
              Consumer<LessonListModel>(builder: (context, model, child) {
                 return FloatingActionButton(
                  onPressed: () async {
                  // 画面遷移
                   final bool? added = await Navigator.push(
                  context,
                     MaterialPageRoute(
                    builder: (context) => AddLessonPage(),
                    fullscreenDialog: true,
                    ),
                    );
                  if (added != null && added) {
                    final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                        content: Text('テクニックを追加しました'),
                    );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    model.fetchLessonList();
    },
    tooltip: 'Increment',
                      child: Icon(Icons.add),
          );
    })
    ),
    );
  }

  Future showConfirmDialog(
    BuildContext context,
    lesson,
    LessonListModel model,
    ){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("『${lesson.title}』を削除しちゃう？"),
          actions: [
            TextButton(
              child: Text("いいえ"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("はい"),
              onPressed: () async{
                //modelで削除
                await model.delete(lesson);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('${lesson.title}を削除しました'),
                );
                model.fetchLessonList();
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
                     },
                    ),
                  ],
                );
              },
            );
          }
        }