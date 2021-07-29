import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _visiblePw = true;
  var _textController = TextEditingController();
  var _psswController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            // we can wrap singlechild.. with center so we center them.
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height:40),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  defaultFormField(
                      validFun: (value){
                        if(value.isEmpty) return "email address must not be null";
                        return null;
                      },
                    keyBoardType: TextInputType.emailAddress,
                    text: "Email Address",
                    prefix: Icons.email,
                    padding: EdgeInsets.all(22),
                    controller: _textController,
                  ),
                  SizedBox(height: 15),
                  defaultFormField(
                    validFun: (value){
                      if(value.isEmpty) return "password must not be null";
                      if(value.length<6) return "password should be more than 6 letters";
                      return null;
                    },
                    text: "Password",
                    prefix: Icons.lock,
                    keyBoardType: TextInputType.visiblePassword,
                    controller: _psswController,
                    isPassword: _visiblePw,
                    padding: EdgeInsets.all(22),
                    suffix: _visiblePw? Icons.visibility: Icons.visibility_off,
                    suffixPressed: (){
                      setState(() {
                        _visiblePw = !_visiblePw;
                      });
                    },
                    ),
                  SizedBox(height: 35),
                  defaultButton(
                    text: 'logiN',
                    height: 50.0,
                    isUpperCase: false,
                    onPress: (){
                      if(_formKey.currentState.validate()){

                        print(_textController.text);
                        print(_psswController.text);

                        if( _textController.text.toString()== "admin" &&
                            _psswController.text.toString()== "adminadmin" )
                          print("Hi Admin");
                        else{
                          print("You can's pass only admins yaw");
                          showDialog(
                              context: context,
                              builder: (context) =>AlertDialog(
                                actions: [
                                  TextButton(
                                    child: Text("Ok"),
                                    onPressed: (){Navigator.pop(context);},
                                  )
                                ],
                                title: Text("Ony Admin Can Pass"),
                              )
                          );
                        }
                      }
                    },
                     //padding: EdgeInsets.all(6),
                     margin: EdgeInsets.symmetric(horizontal: 50),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: (){},
                        child: Text("Register now"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}