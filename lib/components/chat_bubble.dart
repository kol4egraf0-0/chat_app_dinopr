import 'package:chat_app_dinopr/services/chat/chat_service.dart';
import 'package:chat_app_dinopr/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;


  const ChatBubble({super.key, required this.message, required this.isCurrentUser, required this.messageId, required this.userId});

    //воид показывать д-я
    void _showOptions(BuildContext context, String messageId, String userId){
      showModalBottomSheet(
      context: context, 
      builder: (context){
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Репорт'),
                onTap: (){
                  Navigator.pop(context);
                  _reportMessage(context, messageId, userId);
                },
              ),

              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Блокировать'),
                onTap: (){},
              ),

              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Закрыть'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ));
      });
    }
  void _reportMessage(BuildContext context, String messageId, String user){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Репорт сообщения"),
      content: const Text("Вы точно хотите пожаловатся на это сообщение?"),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Закрыть")),
        TextButton(
          onPressed: () {
            ChatService().reportUser(messageId, userId);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Вы пожаловались на сообщение")));
          }, 
          child: Text("Репорт")),
      ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return GestureDetector(
      onLongPress: () {
        if(!isCurrentUser){
          //показывать д-я
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isCurrentUser 
            ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500) 
            : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
        child: Text(
          message,
          style: TextStyle(
            color: isCurrentUser 
              ? Colors.white 
              : (isDarkMode ? Colors.grey.shade300 : Colors.black),
          ),
        ),
      ),
    );
  }
}




