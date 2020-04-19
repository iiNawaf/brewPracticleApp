import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterbrewapp/models/brew.dart';
import 'package:flutterbrewapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, String email, int strength) async{
    return await brewCollection.document(uid).setData({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength,
      'email' : email,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,
        email: doc.data['email'],
      );
    }).toList();
  }

  //user data from snapshot
  User _userDataFromSnapshot(DocumentSnapshot snapshot){
    return User(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
      email: snapshot.data['email']
    );
  }


  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<User> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}