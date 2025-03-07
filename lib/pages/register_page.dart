import 'package:chat_app_dinopr/components/my_button.dart';
import 'package:chat_app_dinopr/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
 final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  RegisterPage({super.key});

  //регистариция функ
  void register() {

  }

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
            "Давайте создадим аккаунт для тебя!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16
            ),
            ),

            const SizedBox(height: 25),
          //email едиттехт
          MyTextField(hintText: "Почта",obscureText: false,controller: _emailController,),
            const SizedBox(height: 15),
          //пароль едит
          MyTextField(hintText: "Пароль",obscureText: true,controller: _pwController,),
            const SizedBox(height: 15),
          MyTextField(hintText: "Подтвердите пароль",obscureText: true,controller: _confirmPwController,),
            const SizedBox(height: 25),
          //логин бтн
          MyButton(
            text: "Зарегестрироватся",
            onTap: register,
            ),
              const SizedBox(height: 25),
          //регистрация
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Уже имеете аккаунт? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              Text("Тогда войдите в него!", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary,))
            ],
          )
        ],
        )
      ),
    );
  }
}