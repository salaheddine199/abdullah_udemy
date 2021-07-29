import 'file:///C:/Users/DELL/Documents/Flutter/abdullah_mansour/lib/layout/todo_app/todo_layout.dart';
import 'package:abdullah_mansour/modules/bmi_app/bmiScreen.dart';
import 'package:abdullah_mansour/modules/basics_app/login/login_screen.dart';
import 'package:abdullah_mansour/modules/basics_app/messenger/messengerScreen.dart';
import 'package:abdullah_mansour/modules/basics_app/users/users_screen.dart';
import 'package:flutter/material.dart';

// THIS SHOULD BE STATELESS 😆

class MyHomePage extends StatefulWidget {

  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)  => UsersScreen()));
                  }, child: Text("List View Design",textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ))),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)  => BmiScreen()));
                  }, child: Text("BMI Design",textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ))),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              /*crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,*/
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)  => LoginScreen()));
                  }, child: Text("Login Design",textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ))),
                ),
                SizedBox(width: 15,),
                Expanded( // we can width so the text on the button will be good
                  child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)  => MessengerScreen()));
                  }, child: Text("Messenger Design",textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ))),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              /*crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,*/
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)  => TodoLayout()));
                      }, child: Text("Todo App",textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ],
        ),

      ),
    );
  }
}
