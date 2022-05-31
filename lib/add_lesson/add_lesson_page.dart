import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osakalivetheater3/add_lesson/add_lesson_model.dart';

class AddLessonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddLessonModel>(
      create: (_) => AddLessonModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('テクニックを追加'),
        ),
        body: Center(
          child:Consumer<AddLessonModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'テクニックの名前',
                    ),
                    onChanged: (text) {
                     model.Tech = text;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'ステージ',
                ),
                  onChanged: (text) {
                    model.Stage = text;
                  },
                ),
                  SizedBox(
                    height: 16,
                  ),
                ElevatedButton(
                    onPressed: ()async{
                      //追加の処理
                      try {
                        await model.addLesson();
                        Navigator.of(context).pop(true);
                      }catch(e){
                        final snackBar = SnackBar(
                          backgroundColor:Colors.green,
                          content:Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    child:Text('レッスンを追加する'),
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