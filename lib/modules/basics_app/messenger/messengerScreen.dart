import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  // what's context?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://syaria.com/wp-content/uploads/2015/11/Ruling-for-A-person-who-Claim-to-Know-about-the-unseen.jpg"),
            ),
            SizedBox(width: 15),
            Text(
              "Chats",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // our search bar:
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 15),
                    Text("Search"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // we removed "singleChild, Expanded=stories, messages".
              Container(
                height: 120, // we added container so we add height so it works.
                /*child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => buildStoryItem(),
                    itemCount: 10,
                  ),*/
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildStoryItem(),
                  itemCount: 10,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 20
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // I don't scroll myself, with the parent.
                itemBuilder: (context, index) => buildChatItem(),
                separatorBuilder: (context, index) => SizedBox(height: 20),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // how to make a list:
  // 1- build item
  // 2- build list
  // 3- add item to list

  //1- our reusable items: // help of arrow function.
  Widget buildChatItem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    "https://syaria.com/wp-content/uploads/2015/11/Ruling-for-A-person-who-Claim-to-Know-about-the-unseen.jpg"),
              ),
              /*CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.white,
                                    ),*/
              Padding(
                padding: const EdgeInsets.only(bottom: 2, right: 2),
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Salah Eddine Merougui",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "HI how's it going bruh dddddddd",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text("02:56 am"),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildStoryItem() => Container(
        width: 60, // width circular image *2
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://syaria.com/wp-content/uploads/2015/11/Ruling-for-A-person-who-Claim-to-Know-about-the-unseen.jpg"),
                ),
                /*CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 2, right: 2),
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Salah Eddine Merougui",
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}
