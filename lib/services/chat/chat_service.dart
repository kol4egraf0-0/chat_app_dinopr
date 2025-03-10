import 'package:chat_app_dinopr/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //инициал бд frb и auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
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
  Future<void> sendMessage(String receiverID, message) async{
    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();


    //создать новое сообщение
    Message newMessage = Message(senderID: currentUserID, senderEmail: currentUserEmail, receiverID: receiverID, message: message, timestamp: timestamp);

    //построить конату чата для 2ух людей
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //добавить новое сообщение в бд
    await _firestore.collection("chat_rooms")
    .doc(chatRoomID).collection("messages").add(newMessage.toMap());
  }

  //получить сообщение
  Stream<QuerySnapshot> getMessages(String userID, otherUserID)
  {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .orderBy("timestamp", descending: false)
    .snapshots();
  }
}