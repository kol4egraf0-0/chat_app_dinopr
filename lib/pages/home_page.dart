import 'package:chat_app_dinopr/components/my_drawer.dart';
import 'package:chat_app_dinopr/components/user_tile.dart';
import 'package:chat_app_dinopr/pages/chat_page.dart';
import 'package:chat_app_dinopr/services/auth/auth_service.dart';
import 'package:chat_app_dinopr/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  //chat i auth

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная"),
        centerTitle: true, 
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.surface // Цвет AppBar
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }
  //_buildUserList для чела которы ща в системе

  Widget _buildUserList() {
    return StreamBuilder(stream: _chatService.getUsersStream(), builder: (context, snapshot){
      //ошибка
      if(snapshot.hasError){
        return const Text("Ошибка");
      }
      //заргузка
      if(snapshot.connectionState == ConnectionState.waiting)
      {
        return const Text("Загрузка контента");
      }
      //загрузка
      return ListView(
        children: 
        snapshot.data!.map<Widget>((userData)=>
        _buildUserListItem(userData, context))
        .toList(),
      );
    });
  } 
  //_buildUserListItem каждого польз
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    if(userData["email"]!= _authService.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"],
      onTap: () {
        //нажал на пользователя -> в таверну
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
          receiverEmail: userData["email"],
          receiverID: userData  ["uid"],
        ),));
      },
    );
    } else{
      return Container();
    }
  }
}
