import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterbrewapp/models/user.dart';
import 'package:flutterbrewapp/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  User _userInfo(FirebaseUser user){
    return user != null
        ? User(uid: user.uid)
        : null;
  }


  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userInfo);
  }


  //Sign in anonymously
  Future signInAnon() async{
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userInfo(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  //Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userInfo(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign Up with email & password
  Future signUpWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData('0', 'Brewer', user.email, 100);
      return _userInfo(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}