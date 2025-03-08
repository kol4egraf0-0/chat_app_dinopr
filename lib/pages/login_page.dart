import 'package:chat_app_dinopr/components/my_button.dart';
import 'package:chat_app_dinopr/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  // email and pw controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  
  //в регистрацию
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});
  // логин
  void login() {

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
            "Добро пожаловать, мы по вам скучали!",
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
            const SizedBox(height: 25),
          //логин бтн
          MyButton(
            text: "Войти",
            onTap: login,
            ),
              const SizedBox(height: 25),
          //регистрация
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Впервые тут? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              GestureDetector(onTap: onTap,
                child: Text("Зарегестрируйтесь сейчас!", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary,)))
            ],
          )
        ],
        )
      ),
    );
  }
}
