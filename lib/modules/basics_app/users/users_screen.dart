import 'package:abdullah_mansour/models/user/user_model.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  List<UserMode> users = [
    UserMode(
      id: 1,
      name: "Merzougui Salah Eddine",
      phone: "0776570722",
    ),
    UserMode(
      id: 2,
      name: "Talbi Amine",
      phone: "0557281694",
    ),
    UserMode(
      id: 3,
      name: "Merzougui Taki Eddine",
      phone: "0548354751",
    ),
    UserMode(
      id: 4,
      name: "Lekird Mohamed",
      phone: "0776570722",
    ),
    UserMode(
      id: 5,
      name: "Merzougui Amine",
      phone: "0557281694",
    ),
    UserMode(
      id: 6,
      name: "Bendif Mohamed",
      phone: "0548354751",
    ),
    UserMode(
      id: 7,
      name: "Lekird Mohamed",
      phone: "0776570722",
    ),
    UserMode(
      id: 8,
      name: "Merzougui Amine",
      phone: "0557281694",
    ),
    UserMode(
      id: 9,
      name: "Bendif Mohamed",
      phone: "0548354751",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding( // or just use Divider
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserMode usermode) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              child: Text(
                usermode.id.toString(),//"1",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usermode.name,//"Merzougui Salah Eddine",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  usermode.phone,//"07765707220",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      );
}
