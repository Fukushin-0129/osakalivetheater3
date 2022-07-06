import 'package:flutter/material.dart';
import 'package:osakalivetheater3/domain/lesson.dart';
import 'package:provider/provider.dart';
import 'edit_lesson_model.dart';

class EditLessonPage extends StatelessWidget {
  final Lesson lesson;
  EditLessonPage(this.lesson);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditLessonModel>(
      create: (_) => EditLessonModel(lesson),
      child: Scaffold(
        appBar: AppBar(
          title: Text('テクニックを編集'),
        ),
        body: Center(
          child:Consumer<EditLessonModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                  controller:model.techController,// ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: 'テクニックの名前',
                    ),
                    onChanged: (text) {
                      model.setTech(text);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller:model.stageController,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: 'ステージ',
                    ),
                    onChanged: (text) {
                      model.setStage(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: model.isUpdated()
                    ?() async{
                      //追加の処理
                      try {
                        await model.update();
                        Navigator.of(context).pop(true);
                      }catch(e){
                      final snackBar = SnackBar(
                        backgroundColor:Colors.red,
                          content:Text(e.toString()),
                        );
                      ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar);
                          }
                        }
                      :null,
                    child:Text('更新する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}