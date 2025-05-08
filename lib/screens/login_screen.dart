import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  void login(String email, password) async  {
    try{
      Response response = await post(Uri.parse("https://reqres.in/api/login"),
      body: {
        'email' : email,
        'password' : password,
      },
        headers: {
        'x-api-key': "reqres-free-v1"
        }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        toastmessage("Account Login successfully");
        print(data);
      }else{
        toastmessage("Failed");
      }
    }catch(e){
      toastmessage(e.toString());
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 2)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 2))
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 2)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 2))
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text("Register",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),)),
              ),
            )
          ],
        ),
      ),),

    );
  }
  void toastmessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
