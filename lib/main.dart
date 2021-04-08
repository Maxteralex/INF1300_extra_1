import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserList(),
      child: MaterialApp(
        title: 'INF1300 - User Manager Interface',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserManagerScreen(),
      )
    );
  }
}

class UserManagerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserManagerScreenState();
  }
}

class _UserManagerScreenState extends State<UserManagerScreen> {
  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserList>(context);
    var items = userList.users;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Manager List'),
      ),
      body: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                key: Key(item.id.toString()),
                onDismissed: (direction) {
                  setState(() {
                    userList.delUser(index);
                  });
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text('Usuário: ${items[index].username} Nascimento: ${items[index].dataNasc}'),
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () async {
              final value = await Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return AddUserScreen();
                },
              ));
              setState(() {
                items = userList.users;
              });
            },
            child: Text('Add User'),
          ),
        ]
      )
    );
  }
}

class AddUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserList>(context);
    String username = '';
    String dataNasc = '';
    return Scaffold(
      body: Column(
        children: [
          Text('Username:'),
          TextField(
            onChanged: (text) {
              username = text;
            },
          ),
          Text('Data de Nascimento:'),
          TextField(
            onChanged: (text) {
              dataNasc = text;
            },
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  userList.addUser(username, dataNasc);
                  Navigator.pop(context);
                },
                child: Text('Confirm'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ]
          )
        ],
      )
    );
  }
}