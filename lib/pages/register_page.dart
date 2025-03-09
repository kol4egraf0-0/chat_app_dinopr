import 'package:chat_app_dinopr/auth/auth_service.dart';
import 'package:chat_app_dinopr/components/my_button.dart';
import 'package:chat_app_dinopr/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
 final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});


  //регистариция функ
  void register(BuildContext context) {
  // Получаем AuthService
  final _auth = AuthService();
  
  // Проверяем, что пароли совпадают и длина пароля больше 6 символов
  if (_pwController.text == _confirmPwController.text) {
    if (_pwController.text.length < 6) {
      // Если длина пароля меньше 6 символов
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Пароль должен содержать не менее 6 символов!"),
        ),
      );
    } else {
      try {
        // Если пароли совпадают и длина пароля правильная
        _auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
      } catch (e) {
        // Обрабатываем ошибку
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Ошибка: " + e.toString()),
          ),
        );
      }
    }
  } else {
    // Если пароли не совпадают
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Пароли не совпадают!"),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
            onTap: () => register(context),
            ),
              const SizedBox(height: 25),
          //регистрация
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Уже имеете аккаунт? ", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              GestureDetector(onTap: onTap,
                child: Text("Тогда войдите в него!", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary,)))
            ],
          )
        ],
        )
      ),
    );
  }
}