import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      child:SizedBox(
                      width:100,
                      height: 160,
                      child:model.imageFile !=null
                          ? Image.file(model.imageFile!)
                          :Container(
                            color: Colors.grey,
                          ),
                        ),
                   onTap: ()async{
                    print("反応！");
                    await model.pickImage();
                      },
                  ),
                  TextField(
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: 'テクニックの名前',
                    ),
                    onChanged: (text) {
                     model.tech = text;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                        ElevatedButton(
                           onPressed: () async {
                           // 追加の処理
                                try {
                                 model.startLoading();
                         await model.addLesson();
                          Navigator.of(context).pop(true);
                                } catch (e) {
                                  print(e);
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(e.toString()),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } finally {
                                  model.endLoading();
                                }
                           },
                          child: Text('追加する'),
                        ),
                  ],
                ),
              ),
              if (model.isLoading)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
            );
          }),
        ),
      ),
    );
  }
}