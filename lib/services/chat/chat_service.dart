import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  //инициал бд frb
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  //id польз
  Stream<List<Map<String,dynamic>>> getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc)
      {
        final user = doc.data();

        return user;
      }).toList();
    });
     
    }
  //отправить message

  //получить 
}