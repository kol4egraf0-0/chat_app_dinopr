import 'package:chat_app_dinopr/auth/login_or_register.dart';
import 'package:chat_app_dinopr/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder:(context, snapshot){
          //пользователь залогнился
          if(snapshot.hasData)
          {
            return const HomePage();
          }
          //пользователь не залогин
          else{
            return const LoginOrRegister();
          }
        }
    ),
    );
  }
}