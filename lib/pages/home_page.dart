import 'package:chat_app_dinopr/auth/auth_service.dart';
import 'package:chat_app_dinopr/components/my_drawer.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Главная"),
        actions: [
          //выйти
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}