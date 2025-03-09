import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
              title: Text("Г Л А В Н А Я"),
              leading: Icon(Icons.home),
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
              title: Text("Н А С Т Р О Й К И"),
              leading: Icon(Icons.settings),
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
              title: Text("В Ы Й Т И"),
              leading: Icon(Icons.logout),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}