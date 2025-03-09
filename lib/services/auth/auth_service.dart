import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //регистрация
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //получить пользователся тут
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async{
    try{
      //рега пользователя
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      //сохраняем инфо если нет еще пользователся
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        },
      );
      return userCredential;
    } on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async{
    try{
      //создания пользователя
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //сохраняем инфу о пользователе
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
        },
      );


    return userCredential;
    } 
    on FirebaseAuthException catch(e){
    throw Exception(e.code);
    }
  }


  //out
  Future<void> signOut() async{
    return await _auth.signOut();
  }

  //errors
}