import 'package:chat_app_dinopr/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //лого
          Icon(Icons.message, 
          size: 60,
          color: Theme.of(context).colorScheme.primary
          ),

          const SizedBox(height: 50),
          //здрасьте снова
          Text(
            "Добро пожаловать, мы по вам скучали!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16
            ),
            ),



            const SizedBox(height: 25),
          //email едиттехт
          MyTextField(hintText: "Почта",obscureText: false,),
            const SizedBox(height: 15),
          //пароль едит
          MyTextField(hintText: "Пароль",obscureText: true,),

          //логин бтн


          //регистрация
        ],
        )
      ),
    );
  }
}
