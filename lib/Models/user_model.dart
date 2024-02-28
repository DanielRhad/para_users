import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String? name;
  String? id;
  String? email;
  String? userImageUrl;

  UserModel({this.name, this.id, this.email, this.userImageUrl});

  UserModel.fromSnapshot(DataSnapshot snap)
  {
    name = (snap.value as dynamic)["name"];
    id = snap.key;
    email = (snap.value as dynamic)["email"];
    userImageUrl = (snap.value as dynamic)["userImageUrl"];
  }
}