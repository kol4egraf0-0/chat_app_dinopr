import 'package:chat_app_dinopr/components/my_textfield.dart';
import 'package:chat_app_dinopr/services/auth/auth_service.dart';
import 'package:chat_app_dinopr/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverID, _messageController.text);
    }
    
    //отчистить textContl
    _messageController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail),
      centerTitle: true, 
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.surface),
      body: Column(
        children: [
          //отображение всех сообщений
          Expanded(child: _buildMessageList(),
          ),
          //user input
          _buildUserInput(),
        ],
      ),
    );
  }
  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID), 
    builder: (context, snapshot){
      if(snapshot.hasError){
        return const Text("Ошибка");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text("Загрузка");
      }
      return ListView(
        children: snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
      );
    }
    );
  }
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data=doc.data() as Map<String, dynamic>;

    return Text(data["message"]);
  }
  Widget _buildUserInput(){
    return Row(
      children: [
        Expanded(
          child: MyTextField(hintText: "Напишите сообщение", obscureText: false, controller: _messageController)),
          //отправить кнопка
        IconButton(
          onPressed: sendMessage, 
          icon: const Icon(Icons.arrow_upward)
        ),
      ],
    );
  }
}