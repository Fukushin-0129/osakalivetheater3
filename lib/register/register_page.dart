import 'package:flutter/material.dart';
import 'package:osakalivetheater3/register/register_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
        ),
        body: Center(
          child:Consumer<RegisterModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller:model.techController,// ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: 'Eメール',
                    ),
                    onChanged: (text) {
                      model.setEmail(text);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller:model.stageController,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      hintText: 'パスワード',
                    ),
                    onChanged: (text) {
                      model.setPassword(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      //更新の処理
                      try {
                        await model.signup();
                        //Navigator.pop(context);//画面遷移
//                        Navigator.of(context).pop(true);//画面遷移
                      }catch(e){
                        final snackBar = SnackBar(
                          backgroundColor:Colors.red,
                          content:Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      }
                    },
                    child: Text('登録する'),
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