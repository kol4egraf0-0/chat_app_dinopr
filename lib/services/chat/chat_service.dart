import 'package:chat_app_dinopr/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{
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

  //все пользователи кроме блокированных
  Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
  final currentUser = _auth.currentUser;

    return _firestore
      .collection('Users')
      .doc(currentUser!.uid)
      .collection('BlockedUsers')
      .snapshots()
      .asyncMap((snapshot) async {
        
        // get blocked users ids
        final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

        // get all users
        final usersSnapshot = await _firestore.collection('Users').get();

        return usersSnapshot.docs
            .where((doc) => 
                doc.data()['email'] != currentUser.email && 
                !blockedUserIds.contains(doc.id))
            .map((doc) => doc.data())
            .toList();
      });
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

  //репорт польз
  Future<void> reportUser(String messageId, String userId) async{
    final currentUser = _auth.currentUser;
    final report ={
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };
    await _firestore.collection('Reports').add(report);
  } 

  //блокировка польз
  Future<void> blockUser(String userId) async {
    final currentUser = _auth.currentUser;
    await _firestore
    .collection('Users')
    .doc(currentUser!.uid)
    .collection('BlockedUsers')
    .doc(userId)
    .set({});
    notifyListeners();
  }

  //анблок польз
  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = _auth.currentUser;
    await _firestore
    .collection('Users')
    .doc(currentUser!.uid)
    .collection('BlockedUsers')
    .doc(blockedUserId)
    .delete();
  }
  //get block user stream
Stream<List<Map<String, dynamic>>> getBlockedUsersStream(String userId) {
  return _firestore
      .collection('Users')
      .doc(userId)
      .collection('BlockedUsers')
      .snapshots()
      .asyncMap((snapshot) async {
        // получаем список заблокированных пользователей
        final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

        final userDocs = await Future.wait(
          blockedUserIds.map((id) => _firestore.collection('Users').doc(id).get()),
        );

        //возращаем лист
        return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
}
}
