import 'package:chat_app_dinopr/services/auth/auth_service.dart';
import 'package:chat_app_dinopr/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
            //лого
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 40,)
              ),
          ),

          //менюшка домой
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("Г Л А В Н А Я"),
              leading: Icon(Icons.home,
              color: Theme.of(context).colorScheme.primary,),
              onTap: () {
                //просто закрытие
                Navigator.pop(context);
              },
            ),
          ),
          //менюшка настройки
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text("Н А С Т Р О Й К И"),
              leading: Icon(Icons.settings,
              color: Theme.of(context).colorScheme.primary,),
              onTap: () {
                Navigator.pop(context);

                //к настройкам
                Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=>SettingsPage(),
                ));
              },
            ),
          ),
          ],),
          //выйти меню
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text("В Ы Й Т И"),
              leading: Icon(Icons.logout,
              color: Theme.of(context).colorScheme.primary,),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}