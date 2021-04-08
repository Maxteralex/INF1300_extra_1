import 'package:flutter/material.dart';

class UserList with ChangeNotifier {
  int _idCounter = 0;
  List<User> _users = [];

  List<User> get users {
    return _users;
  }

  void addUser(String username, String dataNasc) {
    _users.add(new User(id: _idCounter, username: username, dataNasc: dataNasc));
    _idCounter++;
    print(_users);
  }

  void delUser(index) {
    _users.removeAt(index);
  }
}

class User {
  int id;
  String username;
  String dataNasc;
  User({
    @required this.id,
    @required this.username,
    @required this.dataNasc
  });
}