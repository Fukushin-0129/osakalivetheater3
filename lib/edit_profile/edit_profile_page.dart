import 'package:flutter/material.dart';
import 'package:osakalivetheater3/edit_profile/edit_profile_model.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage(this.name,this.discription);
  final String name;
  final String discription;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileModel>(
      create: (_) => EditProfileModel(name,discription,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('プロフィールを編集'),
        ),
        body: Center(
          child:Consumer<EditProfileModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(

                    controller:model.nameController,// ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: '名前',
                    ),
                    onChanged: (text) {
                      model.setName(text);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller:model.discriptionController,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: '自己紹介',
                    ),
                    onChanged: (text) {
                      model.setDiscription(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: model.isUpdated()
                        ?() async{
                      //更新の処理
                      try {
                        await model.update();
                        Navigator.of(context).pop();//画面遷移
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
                    child: Text('更新する'),
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