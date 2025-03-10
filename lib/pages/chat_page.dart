import 'package:chat_app_dinopr/components/chat_bubble.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text(receiverEmail),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey,
      elevation: 0,),
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

    //если настояий пользов
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    //те же самые сообщения для другого чела

    var alignement = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;



    return Container(
      alignment: alignement,
      child: Column(
        crossAxisAlignment: 
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
        ],
      ));
  }
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(hintText: "Напишите сообщение", obscureText: false, controller: _messageController)),
            //отправить кнопка
          Container(
            decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage, 
              icon: const Icon(Icons.arrow_upward, color: Colors.white,)
            ),
          ),
        ],
      ),
    );
  }
}