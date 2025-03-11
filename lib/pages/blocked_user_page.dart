import 'package:chat_app_dinopr/components/user_tile.dart';
import 'package:chat_app_dinopr/services/auth/auth_service.dart';
import 'package:chat_app_dinopr/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class BlockedUserPage extends StatelessWidget {
  BlockedUserPage({super.key});


  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void _showUnblockBox(BuildContext context, String userId){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Разблокировать пользователя"),
      content: const Text("Ты уверен что хочешь разблокировать пользователя?"),
      actions: [
        TextButton(onPressed: () {
          chatService.unblockUser(userId);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Пользователь разблокирован"))
          );
        }, child: const Text("Закрыть")),
        TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("Разблокировать")),
      ],
    ));

  }

  @override
  Widget build(BuildContext context) {
    String userId = authService.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Заблокированные пользователи"),
        centerTitle: true, 
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        actions: [],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBlockedUsersStream(userId),
        builder: (context, snapshot) {
          // Ошибка при загрузке
          if (snapshot.hasError) {
            return const Center(
              child: Text("Ошибка загрузки.."),
            );
          }

          // Ожидание данных
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final blockedUsers = snapshot.data ?? [];


          // Данные загружены, но список пуст
          if(blockedUsers.isEmpty){
            return const Center(child: Text("Список заблокированных пуст"),);
          }
          return ListView.builder(
            itemCount: blockedUsers.length,
            itemBuilder: (context, index){
            final user = blockedUsers[index];
            return UserTile(text: user["email"], onTap: ()=> _showUnblockBox(context, user['uid']),
            );
          },
        );
      }
    ),
  );
}
}