import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signup(String email, password) async{
    try{
      final Response response = await post(Uri.parse("https://reqres.in/api/register"),
      body: {
        'email' : email,
        'password' : password,
      },
        headers: {
        'x-api-key' : 'reqres-free-v1',
        }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        toastmessage("Account Created Successfully");
        print(data);
      }else{
        toastmessage("Account Creation failed");
      }
    }catch(e){
      toastmessage(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 2)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 2)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                signup(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.teal),
                child: Center(child: Text("Register",style: TextStyle(fontSize: 16,color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
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
